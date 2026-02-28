Return-Path: <stable+bounces-220271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJpXMtEwo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA21C595D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F8603102DF8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFB5381CC3;
	Sat, 28 Feb 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZU7meIA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D444B381CDD;
	Sat, 28 Feb 2026 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300174; cv=none; b=JtWyDIIHXzQ/X5nzkVQaMt7ESbQZkxMn4L8pBnhGCoQu+U4pElUYCHWF/cHeN8RkcPubGmVHZfBIy+PEPa0tm82NE9IWqGTF848trejKaRMuxCFDQWvwK6eCeUGcvxE6L/yWwzTH8OuTU3vb15Jbj7MaJ4gcDNc0kuE7XBx0wKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300174; c=relaxed/simple;
	bh=T9FGvJhnf/Nzrx56iXUJ+P2/8aqv2CDO+boMUZgDRfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcEwZEwqLqqEReTFogD8SJrse1Y4NBzF7gLGWzxReYS8Sumxakz/1tJ4Gkf9BxSW6+waeHUoZaX+s2aKf4Cto3Hs6Opwffpy0XNEI4NXiq6LAuleR8R6G+OvvUIam2IJRpEkEtWfzXdxe3MXSizYg0/xrvRnSQPkocPWF5KytaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZU7meIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7112C19425;
	Sat, 28 Feb 2026 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300174;
	bh=T9FGvJhnf/Nzrx56iXUJ+P2/8aqv2CDO+boMUZgDRfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZU7meIAVUCHRBfbjHzL1m3UCjtQEsAxQ1iimSberrQV+hR6e9RA6sQWJquUCcTFL
	 1Opsq9SBEDegttA0+0IvQ0tXGHQrUwTLpgEfo4RW7G9ljAlVpC2EF00OJ/y4umqoxt
	 1RujqgVOcPuEV6pPAczJtTZ79j4LaYsHV2ZLciItKh6S3scJrS4Jg4cKPi6DOEle21
	 yLP3vPmUHq06t3kBZLlHvjhmurfsQmjpHxiWPQcMexfkJ8IvRCrsge+IP8Mnnk9yOY
	 q5qP4txteYC6v40rph8/on9KswYz4Bt9A9Q4BrAGDlQ4Oz+k6HmNbMXSKPRe/Aq3A1
	 pdEFFqAWF4nRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiao Kan <814091656@qq.com>,
	Xiao Kan <xiao.kan@samsung.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 193/844] drm: Account property blob allocations to memcg
Date: Sat, 28 Feb 2026 12:21:46 -0500
Message-ID: <20260228173244.1509663-194-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[qq.com,samsung.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220271-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qq.com:email,samsung.com:email]
X-Rspamd-Queue-Id: 00DA21C595D
X-Rspamd-Action: no action

From: Xiao Kan <814091656@qq.com>

[ Upstream commit 26b4309a3ab82a0697751cde52eb336c29c19035 ]

DRM_IOCTL_MODE_CREATEPROPBLOB allows userspace to allocate arbitrary-sized
property blobs backed by kernel memory.

Currently, the blob data allocation is not accounted to the allocating
process's memory cgroup, allowing unprivileged users to trigger unbounded
kernel memory consumption and potentially cause system-wide OOM.

Mark the property blob data allocation with GFP_KERNEL_ACCOUNT so that the memory
is properly charged to the caller's memcg. This ensures existing cgroup
memory limits apply and prevents uncontrolled kernel memory growth without
introducing additional policy or per-file limits.

Signed-off-by: Xiao Kan <814091656@qq.com>
Signed-off-by: Xiao Kan <xiao.kan@samsung.com>
Link: https://patch.msgid.link/tencent_D12AA2DEDE6F359E1AF59405242FB7A5FD05@qq.com
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index 596272149a359..3c88b5fbdf28c 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -562,7 +562,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
 	if (!length || length > INT_MAX - sizeof(struct drm_property_blob))
 		return ERR_PTR(-EINVAL);
 
-	blob = kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
+	blob = kvzalloc(sizeof(struct drm_property_blob) + length, GFP_KERNEL_ACCOUNT);
 	if (!blob)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0


