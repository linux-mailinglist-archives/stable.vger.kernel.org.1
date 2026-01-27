Return-Path: <stable+bounces-211903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CKyKJJQeWnYwQEAu9opvQ
	(envelope-from <stable+bounces-211903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 00:56:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F169B87B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 00:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3C2F3018C0F
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0372F6181;
	Tue, 27 Jan 2026 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDfkmBEA"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B2245031
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558158; cv=none; b=EA98itIpxZZK/a27TLooNGd3dOBNkcbSMpRt/q8+MOcGlfgYy0AoaKe+jsPgzqcHdG91XIsqEWYOeq3yjslMw11huUhcPwg6r/xam/ZK7X4/KwjIyf7S+N0kDNCf4eprADFFOSSd8dMpcGzkYty+MoYV+SXuQB3ENt4cYRTzjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558158; c=relaxed/simple;
	bh=1bdvDWy3ayORJJpYAh61pTdmvx/lpSGKvlPrNdsqbzE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ow4zXTKwVKPqtKXIneom8JXucASg8WnqCvM5gCUYUAwLSLgsayyetlThgKHk0bL1urdLWo72QP3naC1JLgiXJhAQmkrUi2dtUwaMiF5Pc3jP71M2DTQwqAfRjTwtHRTHoC9fU+KYH6S0Wv1R2LuGUuGVDApH/wzJzCz0Fi9Yx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDfkmBEA; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1248da4d2d6so5036776c88.0
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 15:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769558156; x=1770162956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tdCSuV7lwZVI5Oxf115A/DnTg8grqC5WgVzeqsLUVUc=;
        b=XDfkmBEAqTlQbG+DHKMGgirINNHy1Dw+bSzPjATWlqvfxaFOY4uxSWoCpG94bFJJXJ
         DsGuH0by0Xh4Cfo2Q87gmBBb9uZAvUU2+oftoJuVB+Po8SKUafM1jY0AFqxffFhBC9yq
         OdNSU8LilWGKHg2Ea1g7XsGuXMh1na63HzQbyeDqBTUPdurlQPt6TOtSDLgWCzRulRma
         phDeVw5kDuop3D+ygstKo16cAo56hdnCdIhn4aW0KnCTjMtsoURY5Se+4EWOfY7HGVQc
         nLYLbLrmvIcdvvmIDURuaQ/OCO14r1ZC4y1YWx0t4vbttLMMZEdQuVYfZQEfHS+crz0J
         L1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769558156; x=1770162956;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdCSuV7lwZVI5Oxf115A/DnTg8grqC5WgVzeqsLUVUc=;
        b=vLHPZvyTVNc0Zgv/0NXt/P+UA+mxzSEIHrBhVeAiF/LqPZ6wjphzwbEhrxFXiq38dd
         RntGQU20t14Q3Ll7r5aTE05nH4vArFWoMOTcQbepj7opcd7lnVrWZKgPRJRxUc7SWMT+
         bUiDstJcIdoIX3bU07lSx9lBA4g0UZNcvAk4LnWMad9hQ0pB2aKRAv1R8rxXc9mbdlIB
         I6aHtiLlWj/JAZ2LioR4HA6wg3O7tKXnpJltrm0cNwuOrFpkKNTXF0DpzX+V0FeUx71z
         WrJGMmoEl6ae+qK+mBI7Z8UUyFIf9HlRYhegUxQMea2q6cC8Eva3WVu7oOunpibpW2Nw
         PkXw==
X-Forwarded-Encrypted: i=1; AJvYcCXbTntk0f2vCSzKJFd00jWyx7XzHMd71k+qv89oUNH5BvGG6heX5zW8I8vr8Qe5cxCtTq4yzKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWOws5NKl0ufz0i0axCPhp2ZR0MG1WRbVRPrTchIHiK6vMlfO
	Ee9ZQfqoDJFDuz1cl/dy5GJNAvJLrxL2+UeOV7u8tVedRRup4lEfYR7uPpQDH0SkOuzAQD5rfwC
	8XsJlBVSNpVAtCA==
X-Received: from dltt2.prod.google.com ([2002:a05:701a:c962:b0:119:78ff:fe10])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:24a9:b0:119:e55a:9c08 with SMTP id a92af1059eb24-124a0114330mr1992149c88.36.1769558155760;
 Tue, 27 Jan 2026 15:55:55 -0800 (PST)
Date: Tue, 27 Jan 2026 23:55:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127235545.2307876-1-cmllamas@google.com>
Subject: [PATCH 1/2] rust_binderfs: fix ida_alloc_max() upper bound
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>, 
	Matt Gilbride <mattgilbride@google.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Li Li <dualli@google.com>, 
	Paul Moore <paul@paul-moore.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,android.com,kernel.org,google.com,yandex.ru,zeniv.linux.org.uk,brown.name,gmail.com,paul-moore.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-211903-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9F169B87B
X-Rspamd-Action: no action

The 'max' argument of ida_alloc_max() takes the maximum valid ID and not
the "count". Using an ID of BINDERFS_MAX_MINOR (1 << 20) for dev->minor
would exceed the limits of minor numbers (20-bits). Fix this off-by-one
error by subtracting 1 from the 'max'.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202512181203.IOv6IChH-lkp@intel.com/
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder/rust_binderfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/android/binder/rust_binderfs.c b/drivers/android/binder/rust_binderfs.c
index c69026df775c..88374b31ab7c 100644
--- a/drivers/android/binder/rust_binderfs.c
+++ b/drivers/android/binder/rust_binderfs.c
@@ -132,8 +132,8 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	mutex_lock(&binderfs_minors_mutex);
 	if (++info->device_count <= info->mount_opts.max)
 		minor = ida_alloc_max(&binderfs_minors,
-				      use_reserve ? BINDERFS_MAX_MINOR :
-						    BINDERFS_MAX_MINOR_CAPPED,
+				      use_reserve ? BINDERFS_MAX_MINOR - 1 :
+						    BINDERFS_MAX_MINOR_CAPPED - 1,
 				      GFP_KERNEL);
 	else
 		minor = -ENOSPC;
@@ -405,8 +405,8 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	/* Reserve a new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
 	minor = ida_alloc_max(&binderfs_minors,
-			      use_reserve ? BINDERFS_MAX_MINOR :
-					    BINDERFS_MAX_MINOR_CAPPED,
+			      use_reserve ? BINDERFS_MAX_MINOR - 1 :
+					    BINDERFS_MAX_MINOR_CAPPED - 1,
 			      GFP_KERNEL);
 	mutex_unlock(&binderfs_minors_mutex);
 	if (minor < 0) {
-- 
2.52.0.457.g6b5491de43-goog


