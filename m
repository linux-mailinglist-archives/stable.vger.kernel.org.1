Return-Path: <stable+bounces-179488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF9AB5615B
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F43A02E0F
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA25A2F0663;
	Sat, 13 Sep 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg4apajd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB162EFDB9
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772630; cv=none; b=DC18DLtXFh9xwGYx5AclcLQ+Y1915/me+JZiLoqAFBSGfuWZIIuRgNPy/tiWkFjoTqfxm1NMTKoPgOGx4ofMb2lCYAJEP6qdmk1wL9EdQu772uhPtcEsNeDqvrjsz4c2OKPSq4qK3kPXBnFQmVABUVVCD6ANFx7SJUGjV5w8LXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772630; c=relaxed/simple;
	bh=6rdtiEGvkclfGLWRM/V/ie2JppMbyGpHActh3U34Thg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXP03FOOyrHKuC4uGolzZkijWhh4jo4yDgBUuW5rjchCU4otz1J3Ni54MiYSD4kJK5IRKD8g/c0mC/en7XfIUdlF3Z1w2WFrSRknTvD5XjtswhUWw2Wv+IKi6JaQJ8Ldb+Mqd/IgjSiqkX4efH1Ik8KMvZCWQzQ5rGU0YRtaP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg4apajd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D00C4CEF9;
	Sat, 13 Sep 2025 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757772630;
	bh=6rdtiEGvkclfGLWRM/V/ie2JppMbyGpHActh3U34Thg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dg4apajdiUEKAr2jHpHZuTlzeENQi8+QA1THN4o/R0ryXO5K9S5GQc8r0izRKvC6w
	 ZT0/TjLtIFa/Ffo8ONWzk0yKzQOT8JG+rul2Iw5bcyJ/krrQU9VSiLsr4s10Q5hg1S
	 YCz/0ZWxX3DYOrYGGOYffsSFESbWn6E85mvYbWQrTPdMxcz7+Sbe6KAaELWAsDQfe+
	 O7U7s1jzKedQazuAsm+C3PK8jBYkn2FBW+TSHPWoafv4CwIHU4IlcCBSd5PlxlwjQw
	 PE96Mi9PsV1UufCOlOTP8bMtTYsDhRYvye7CKypCVTY920lObl9nx7X4iU9EnVj5cx
	 rD9Jd+X44T95Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] netlink: specs: mptcp: replace underscores with dashes in names
Date: Sat, 13 Sep 2025 10:10:25 -0400
Message-ID: <20250913141026.1362030-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913141026.1362030-1-sashal@kernel.org>
References: <2025091346-avenue-afterglow-5b42@gregkh>
 <20250913141026.1362030-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 9e6dd4c256d0774701637b958ba682eff4991277 ]

We're trying to add a strict regexp for the name format in the spec.
Underscores will not be allowed, dashes should be used instead.
This makes no difference to C (codegen, if used, replaces special
chars in names) but it gives more uniform naming in Python.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250624211002.3475021-8-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 7094b84863e5 ("netlink: specs: mptcp: fix if-idx attribute type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 8 ++++----
 include/uapi/linux/mptcp_pm.h             | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 59087a2305651..170903a624a84 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -57,21 +57,21 @@ definitions:
       doc: >-
         A new subflow has been established. 'error' should not be set.
         Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: sub-closed
       doc: >-
         A subflow has been closed. An error (copy of sk_err) could be set if an
         error has been detected for this subflow.
         Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: sub-priority
       value: 13
       doc: >-
         The priority of a subflow has changed. 'error' should not be set.
         Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
-        daddr6, sport, dport, backup, if_idx [, error].
+        daddr6, sport, dport, backup, if-idx [, error].
      -
       name: listener-created
       value: 15
@@ -255,7 +255,7 @@ attribute-sets:
         name: timeout
         type: u32
       -
-        name: if_idx
+        name: if-idx
         type: u32
       -
         name: reset-reason
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 84fa8a21dfd02..6ac84b2f636ca 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -27,14 +27,14 @@
  *   token, rem_id.
  * @MPTCP_EVENT_SUB_ESTABLISHED: A new subflow has been established. 'error'
  *   should not be set. Attributes: token, family, loc_id, rem_id, saddr4 |
- *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if-idx [, error].
  * @MPTCP_EVENT_SUB_CLOSED: A subflow has been closed. An error (copy of
  *   sk_err) could be set if an error has been detected for this subflow.
  *   Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 |
- *   daddr6, sport, dport, backup, if_idx [, error].
+ *   daddr6, sport, dport, backup, if-idx [, error].
  * @MPTCP_EVENT_SUB_PRIORITY: The priority of a subflow has changed. 'error'
  *   should not be set. Attributes: token, family, loc_id, rem_id, saddr4 |
- *   saddr6, daddr4 | daddr6, sport, dport, backup, if_idx [, error].
+ *   saddr6, daddr4 | daddr6, sport, dport, backup, if-idx [, error].
  * @MPTCP_EVENT_LISTENER_CREATED: A new PM listener is created. Attributes:
  *   family, sport, saddr4 | saddr6.
  * @MPTCP_EVENT_LISTENER_CLOSED: A PM listener is closed. Attributes: family,
-- 
2.51.0


