Return-Path: <stable+bounces-58602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A8A92B7CE
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7131F244B5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5FB156C73;
	Tue,  9 Jul 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wtnyGnlD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926927713;
	Tue,  9 Jul 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524436; cv=none; b=bsiTivCUjz3W5Yf+pyi+YwxGZHM6IE6wQK4TABGKg/LyT39Ed6tJLZjoEuHing8i3pFSk479SnjTQBof1YyGTv1onWQPr4Fype99OGbsNleTShl1kGJgtwejl/fQlBpb34oeoqfzaWsRmJDIpYlg2zG99Nb0xAIg9+RR81ZTWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524436; c=relaxed/simple;
	bh=Fh6ZiXksQwOTzX6ruQZQBQgp3xm6aT9XJu68/EM/Gd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGsgvJ9LGiIpZJgQtQ1x2vlqk9AXwpCL9C78IJqxIK6omIAM4ac9gE6fResF54TdmynapbZUXyZyOGSfMCFpH8WNPGb7raCPEnr6brPwmF+l2q6DwEegM9PRYAaMKRvRgRjTYgdpAG/2e0pgRXI2t631098lOqDNVLbfObtqG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wtnyGnlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04503C3277B;
	Tue,  9 Jul 2024 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524436;
	bh=Fh6ZiXksQwOTzX6ruQZQBQgp3xm6aT9XJu68/EM/Gd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wtnyGnlDBGSQi6qklLlM+mYfURLPIZo9WWoTHMggvo9B6ENegMzxFO6J1v+4b9tu/
	 YjzuqOZ3/wQbV5+luRNNUf3HxxRyYsZ3ITplp3mvIcAkMBfFOSIwF1V/pnTNJmTTFI
	 UiYryCaoTREIlMqK937j+sjQCMJxKwKx2XSBrcSY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Jan <zoo868e@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 181/197] connector: Fix invalid conversion in cn_proc.h
Date: Tue,  9 Jul 2024 13:10:35 +0200
Message-ID: <20240709110715.948539202@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Jan <zoo868e@gmail.com>

[ Upstream commit 06e785aeb9ea8a43d0a3967c1ba6e69d758e82d4 ]

The implicit conversion from unsigned int to enum
proc_cn_event is invalid, so explicitly cast it
for compilation in a C++ compiler.
/usr/include/linux/cn_proc.h: In function 'proc_cn_event valid_event(proc_cn_event)':
/usr/include/linux/cn_proc.h:72:17: error: invalid conversion from 'unsigned int' to 'proc_cn_event' [-fpermissive]
   72 |         ev_type &= PROC_EVENT_ALL;
      |                 ^
      |                 |
      |                 unsigned int

Signed-off-by: Matt Jan <zoo868e@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/cn_proc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index f2afb7cc4926c..18e3745b86cd4 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -69,8 +69,7 @@ struct proc_input {
 
 static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
 {
-	ev_type &= PROC_EVENT_ALL;
-	return ev_type;
+	return (enum proc_cn_event)(ev_type & PROC_EVENT_ALL);
 }
 
 /*
-- 
2.43.0




