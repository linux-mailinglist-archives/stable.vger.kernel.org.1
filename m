Return-Path: <stable+bounces-256415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJMeE1muGGrBmAgAu9opvQ
	(envelope-from <stable+bounces-256415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:06:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC77B5FA396
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF0530C5108
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8B32E736C;
	Thu, 28 May 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="PQvqyjMG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDB1DED49
	for <stable@vger.kernel.org>; Thu, 28 May 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001949; cv=none; b=QV63OJf/KrS7As3K9pknV4yeoko7hDg4Lh+2dpS3ROWMoHmlEdwvC3pfC2nM3nPaZMRmXYD1HxxORadtPXr6AGeZIzSH0+ecT5NgyKESlvS8kiXvnvsfJr8+1u0PgGYEylWdM+D/pB/apGzf60f+XlfUNGTC8d5qkgRZ8usG1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001949; c=relaxed/simple;
	bh=QWVuf5BpUt+Js6oaDZCRJWZR6aE41jAGjjzz/JiWek8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=B8371Hfir8ZFHTg1tOuOm9G/J5Kmvueh4g1kQ+SfpXDpVoI6fWM11J+LZ4vC2P90cJrtl4wVUs317Bi1bnN7BWURutkLfjsZKbmpYa05AwPhbogKvv7q9pAYTTmQ2nQUIN5wcKvtat4qifgjUXRvpKO4krUGOPQFoRuqe3DWfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=PQvqyjMG; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3044857f09aso9425821eec.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780001947; x=1780606747; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W4is2ZaNAM3rg10Mm8PAbNG51BuI85TH1aqHwikNUE=;
        b=PQvqyjMG7YuMV2nQn7GtyNO42iQrZFB0/AKtfI6d17RZnU2IdF5K38OFQm86JDDbiq
         XFoWFKZSZ1hru8eUlc3/9k1mFKYhdxy1VXjE7NmwVe5KIoKTq7sqeVQnZ8L6BPm2AJ4N
         rKw9KDq9x/+vkO1FNykkNEPbuZ7Lsx0zq7qtEnubGY4udFq8WzKNypTRMUii6Cgxy2m6
         Momq9MkOpLB2xyzIaPijpfADTluS/5IflEYFAmIC/DyY/3Yr89gbbkf0aeDQIPuXlI14
         fE+W4zB+maYb7wnGWuRYIe9CMz3bb7QVIq0cXbhsPgQtkcyrOqGiM1NPK51oVJLFHcj4
         WspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001947; x=1780606747;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9W4is2ZaNAM3rg10Mm8PAbNG51BuI85TH1aqHwikNUE=;
        b=hQ9q9p2EdXbZl2NX+NvHyiym+VwCfQCT6zIpf3a3HPdbyCML/i8lXa0VwysXKzcfyi
         1mUUR2COt1VM6of5WddMRXENHPkxtkUvBAGv+SELYqqRVePHxfo5wg3qo56swh1T22E+
         HQpU4lEQOr7XIsnnAv8inKdS/jacL2imV28dDDX1SMXi2ci0+zRDxkznOOjzn0zrCAgI
         S/oylECdk4og/T2phnfbWbTbyzXslf4mlKt3AHvU07PFrDtWt+RVD1otPjTSLJY8dfe2
         B0p63elQlEN1Z0fXYIcx64rxZ/7BFsGSZ8QFAL254Kdan+SNQZHNA+lf1uULOlpWBeDY
         OncA==
X-Forwarded-Encrypted: i=1; AFNElJ+bWU8Dw1VyMkSaXD3hfWpY5OCF43UprdBJ2tUtREJSvO2EnmEUo7t2JhiwNz0cB0nKebDPOZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAHbVnfxuErS/60vL5eT/TCLPW7I3yo/HaMvX20X/sY1fjxg0
	DrpRSizzB0Pk3QjlEHw/wRvmhaKQ3Kz1PM3VnOzg+Y3WfH68cg3NtWomyL0pw263ZD4=
X-Gm-Gg: Acq92OGQbwRta3oPi/+C3rstPRUkIya5Y6gaZ0afGYFIRBBUPsFwaFvAA7C3/RHFfXV
	USM+aUU8ZQhrAGs8WjkTw3IfpNniHKF0ZxAoOfOw117cUVz1SnlBpIVP0OYue8ebvxeBE4ibsA8
	VpJGkzOdL+mTbxSP0bzkT4hP+/UFoZ/WC3MH9gKdV53e/UnYrgq6lz7YxN+Sh2fDPXTGQoRBJTt
	JxtwVnG+ydMD6xxPUYuTiOGTCOGIPel4rySRr6jzIJePc/KttXD+4a/39InExEbUXlfjgfPPKqN
	qRVC/lFN+JkFdmBellDERDQMhUh4YGoiAHXW2xmsSlt3+aoJILnCHiwzT8LBT/vuVH7496gUzyd
	m1aqOrleJZvfcY6BdJPdz3eRly4sKNGzty3pW4LonclZwfaxArNcE+WiWGUm9o8bnO4Lq5BmveV
	md9+Y8KgEx9QWsQU0PjU3DAAbl5nU=
X-Received: by 2002:a05:7300:430a:b0:2de:2f38:a7cb with SMTP id 5a478bee46e88-304eb1f6384mr58075eec.18.1780001947020;
        Thu, 28 May 2026 13:59:07 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304e99788fcsm267351eec.27.2026.05.28.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZCkgLi9p?=
 =?utf-8?b?bmNsdWRlL2xpbnV4L2Jpby1pbnRlZ3JpdHkuaDoxMDE6MTI6IGVycm9yOiDigJhi?=
 =?utf-8?b?aW9faW50ZWdyaXR5X21hcF8uLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 28 May 2026 20:59:06 -0000
Message-ID: <178000194591.7095.11275948264529325340@330cfa3079ca>
X-Spamd-Result: default: False [-0.66 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-gcc-14-i386-6a189f8cee38c2a863e3d06e/.config];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256415-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,kernelci.org:url,kernelci.org:email,kernelci.org:dkim,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC77B5FA396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 ./include/linux/bio-integrity.h:101:12: error: ‘bio_integrity_map_user’ defined but not used [-Werror=unused-function] in block/bdev.o (block/bdev.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:f6c8b85f1de48666821b8110b7be27db7b679266
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  97928cc88900a9fb07a4dddbd1db19eb0ce55c56


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
                 from block/bdev.c:15:
./include/linux/bio-integrity.h:101:12: error: ‘bio_integrity_map_user’ defined but not used [-Werror=unused-function]
  101 | static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
      |            ^~~~~~~~~~~~~~~~~~~~~~
  CC      crypto/aead.o
  CC      kernel/sysctl.o
In file included from block/blk.h:5,
                 from block/fops.c:21:
./include/linux/bio-integrity.h:101:12: error: ‘bio_integrity_map_user’ defined but not used [-Werror=unused-function]
  101 | static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
      |            ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## defconfig+kcidebug+x86-board on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-kcidebug-6a189fc1ee38c2a863e3d0a8/.config
- dashboard: https://d.kernelci.org/build/maestro:6a189fc1ee38c2a863e3d0a8

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6a189f8cee38c2a863e3d06e/.config
- dashboard: https://d.kernelci.org/build/maestro:6a189f8cee38c2a863e3d06e

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6a189f9eee38c2a863e3d089/.config
- dashboard: https://d.kernelci.org/build/maestro:6a189f9eee38c2a863e3d089


#kernelci issue maestro:f6c8b85f1de48666821b8110b7be27db7b679266

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

