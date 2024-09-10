Return-Path: <stable+bounces-75474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277409734D2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CDC1F25C9C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2591E191F73;
	Tue, 10 Sep 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tLygIzs1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B81191F70;
	Tue, 10 Sep 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964838; cv=none; b=Ms0TPRxU7SreFopCmRVuqOrZudwM4rH668RSt8q72JHa0AEvdRkuxpv23axBnL+y6ruCw2ZEsm2DEOAnGbpDElVMPbAqr0sWbHDVl1WCHbQSkoeCrcUm+wsrYSLmUrodPqxn5PPY1yFq4bae2gouXZEHys/qQH/vbzTqzKpXAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964838; c=relaxed/simple;
	bh=ZIIhzErESG+1CMM43CwWCBLdFAw8DCUaomsFss+zPf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHzaVwaibSLySCxlQ9nLN/Q60w546SS0y8iUCyEPGdJ5AJIH23WvymV0aj9oC5ZuQ0BZDo5oGCz1f2MYaX8RQYsRfnhO/XUg/Cjv0XSG/YHrFRA913D4/uQCTstX6qVR/SnDFtClbhY5jC1GkYkAtRlzKvsOkQn+loeKuDlELEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tLygIzs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59485C4CEC3;
	Tue, 10 Sep 2024 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964838;
	bh=ZIIhzErESG+1CMM43CwWCBLdFAw8DCUaomsFss+zPf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLygIzs1b1FKXLPBzU0wOuNQARpJDS1g6i2HVe9Kk7xYxtOIwDbNrg23PZemurzED
	 WqUp87zvW1JKjvckxjiuVMoL1SVr70vAES3dvVHOkNput4DMMTquwimvS9L5jVOUZx
	 FllvDv8Ju49V0/6nACgojickXGmXRDI88nHjQv60=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Kiryushin <kiryushin@ancud.ru>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH 5.10 049/186] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
Date: Tue, 10 Sep 2024 11:32:24 +0200
Message-ID: <20240910092556.529674794@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Kiryushin <kiryushin@ancud.ru>

commit cc5645fddb0ce28492b15520306d092730dffa48 upstream.

There is a possibility of buffer overflow in
show_rcu_tasks_trace_gp_kthread() if counters, passed
to sprintf() are huge. Counter numbers, needed for this
are unrealistically high, but buffer overflow is still
possible.

Use snprintf() with buffer size instead of sprintf().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/rcu/tasks.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1240,7 +1240,7 @@ static void show_rcu_tasks_trace_gp_kthr
 {
 	char buf[64];
 
-	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
+	snprintf(buf, sizeof(buf), "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));



