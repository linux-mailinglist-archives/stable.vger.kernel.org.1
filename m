Return-Path: <stable+bounces-72684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA35968215
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1141F23115
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E41186E24;
	Mon,  2 Sep 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DX2Btwpt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85EF185952
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266140; cv=none; b=Amg6ulVB40t41KfLgQc6uAYl8uQrs+JqP2BAW4g5hEd81+a4nwIieeBtMweql893irgqCqihi1bXWneBL+3RJxQ4M4B7py55+RzW9/zVz91AXU9UgwyDWjSLjzFyOhTtndvMQSkcwDo9zcS5vWy9bUFXkiL69L3j7PZ9T3PoaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266140; c=relaxed/simple;
	bh=1yKUWgG168kIrumQ4E/lNDOE3dBsj4G/DSSmNyd+u94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmA2huUuXkmAvHLkjHOKLMVbZzF0rU5kaeCJlz6HBJkUtpDzw0pA2zWYbktDHzKRnd72wrIsngomU+YvOQ6Ca0XQDRfpVbuZt0hQLnsc7oJpLxBeOd9ozG9GCiO03Inm7HUJ9B6tWIKRhOLrylsrIdwVhPzHBLdgWeMShU5KBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DX2Btwpt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d89348de8fso1249398a91.0
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725266137; x=1725870937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx+Ngpcz5KS+uT4ExH5gnibO/Q2OSWyZ6WFtEESiF1s=;
        b=DX2BtwptwtS4S4LBkTC5TJtMYYPfTtxYEzIl6ZwsNPN42edbg1+oW35RQKCxFMV1zd
         XMToc86V+mqsYsBiCq6dAc01qN+xl13lufgCZBS+g9Wau+9Cb42CD/MMuSuvPgieTI1V
         wuoxWYJy1SP58CHZi8WnaGxhsLahSEEXhVZ90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266137; x=1725870937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx+Ngpcz5KS+uT4ExH5gnibO/Q2OSWyZ6WFtEESiF1s=;
        b=t/UtjDJ0k4hfiCEfhVGPjJaR7lH4goIcOIjPp8y8hul/tSmG8cwRD49IHsj/xsLjIy
         Y0rwpPS1tJrVK00rvudDaXvSTL8mhlzFjjvSk6IkNS+js8O05+5goYjarxFNf1gnfLMr
         g7ww+swvJZA85Xt99RqEn1vk24J8pRdDzD/JijuV8WIUw4Qep4jWaVGE8mZjhSwmMPh6
         ZAzk9ucoqxWrQnOhbUUVLBd87EE1Qf8SpTps+XdwcIS1BwgH88RKH4BcU7XogDL+/3EB
         j/B0cAJsL9HiekXlEM2vEHl1nnLsojejYQAoZT4+7REoijnFxnvXsdviQGviy7Io//Vg
         bOIw==
X-Gm-Message-State: AOJu0Ywbk8LjMLj+yWqDpjDHnH+1hr0CSHEQR0XEbNYoaH8wqXh01ZOG
	E7hyJyp9oJHfbaFCokqYVRGdtdBeUnPLrYEpZRZhW3YxkR/UOMS2CIBEJ7hKbK7POddQ897Wa+N
	smUrL0atbMDpJCjiYqMO6iaC1xUX/vva52tm9hb/P/feD2lgCAJRGh+Gm6nRCC80gwfSyPdRIiq
	TRh3Cg5lC4dLrdIbeHFxMWLUucWXNcNzB1P2PxzbZAQP/8UJhPb7zpRqc3bY7oueU=
X-Google-Smtp-Source: AGHT+IF4/GEqSbXqoxRakIqILSzbtpCjeIMTeUiOM4xZC1PMAowJYIU5DaWRW0ooWvdCC6o+o1UIWQ==
X-Received: by 2002:a17:90a:558f:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2d88d6a0b9fmr7246707a91.14.1725266136913;
        Mon, 02 Sep 2024 01:35:36 -0700 (PDT)
Received: from fedora.. ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b3b95e8sm8511509a91.54.2024.09.02.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:35:36 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Nikita Kiryushin <kiryushin@ancud.ru>,
	Sasha Levin <sashal@kernel.org>,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v5.10-v5.15] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
Date: Mon,  2 Sep 2024 03:33:55 -0500
Message-ID: <20240902083422.1095022-2-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikita Kiryushin <kiryushin@ancud.ru>

[ Upstream commit cc5645fddb0ce28492b15520306d092730dffa48 ]

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
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 105fdc2bb004..bede3a4f108e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1240,7 +1240,7 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
+	snprintf(buf, sizeof(buf), "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));
-- 
2.45.2


