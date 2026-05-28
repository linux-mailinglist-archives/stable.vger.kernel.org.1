Return-Path: <stable+bounces-256414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNHlDFWuGGrBmAgAu9opvQ
	(envelope-from <stable+bounces-256414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:06:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940475FA388
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E45773100DF5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578401E1DE5;
	Thu, 28 May 2026 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="cn3KoaYF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB61C3318
	for <stable@vger.kernel.org>; Thu, 28 May 2026 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001948; cv=none; b=l0PN3X6VD1wmpxExwzhMn98zMLWAINF3j+sh3WKaVdgDhT1DNjPIN9FqZY1OvCvG26PW/Z6op9gAV5aNdokmTnAbS3zmqosyo57Rutuf7vadpJnqkydEZfxUAVm7NNDGEc0Pz7MlJW+0hbgXynw+sKUaOkaNDoBdjAfhBhH9giw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001948; c=relaxed/simple;
	bh=zxs6TdpFGz1It3CQs+gX17gWknbVkAFr1oIBnX05BCA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=udX42dCedo6dGQnHl/IHyGEMwgUXYDELmS9r0UtfbLL9gXsvbPKIHk83HIZ+cjSvUK5IvE1dDcq6o6C/klu6Ey/2V+9Un0S9+9z+1H+8EjH+ElNbz5IzESWhIdyqMvaa/donmF/EA4EG04HTWNaBf3jUZRnX58rALWiwfc5WQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=cn3KoaYF; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304e58292d3so987778eec.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780001946; x=1780606746; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JtpKfiga7kxvCC80bF6XPFJMebEQsCFw9Ec/kVEc34=;
        b=cn3KoaYFii/31kuHk/1imdtnyYDx8qjGC8XI5yWdw/eiybXxJAMhv/aqbbQw1QRxq7
         jk+Jqy4ct9vwRDWtVO976n3M4jUidx7nLIgxhIwcvwoUIQXOfGw0+NNwp+2tFXu1WDCv
         uyHwaqYfFVynEn3K7jiegVowD8RmSA4fFaiyZHZnyGtqwKmSB88Pt5+ZdfhEeXorYAjo
         uszqBxIRPair2m+eNhq1AygkQKtO8wPVpX7PwCsDeqAWkKKpk+v4kroFfffBkp6nXcNL
         mdg6Afj2lm0LwMCjQpeDWVbaK7MbW3OcEal/MrbyjzIOmZ/mdslHAFRAgKK1JKe18sfd
         y2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001946; x=1780606746;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JtpKfiga7kxvCC80bF6XPFJMebEQsCFw9Ec/kVEc34=;
        b=tVUVubMEtSuGQq6kLbk36YVpfSe/1P/KaNQ7CZmCPqOap/PHlx/tcgjYhWjW7xZZNl
         L997gBfEKRD6U2wTOUyuzajUun++9Bm/V3jwAup+gjqOV26xO6U8K1t0nGPZVLix2FRf
         +c23Y4mFa91Cackqa4jq0reMCS/jFfHrXzMbmD+FmEm5nCBcrORUVRor6ae/8zewDtzE
         RkidTh7nfiU9XlkCxRKCPtKfDSio5rEk4g4p/LfHivr4rdysfoX28XS51+W4+Do5orpB
         16Zu/mmTB8ChN94ohpqFg5nVaXmAid89prTXewGxFfib3Ia7eFeF53zM8uws9tbKtnxH
         iI3A==
X-Forwarded-Encrypted: i=1; AFNElJ+h04Zr0LKf/9YEwPXd8Iimt4nvjk6RX+1CG19ta3xS7g9D/y/UzePippBJC7wfaw+oSGMGXIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqAROK0YAn5IjxBhnKy3Iuj0HEUA+kGGajh0tM8eUr/8O0g+b
	L8Zd8xTpsRl5wsQBrmPOdkuqY5KbHNFaiG8A3gWHRHoTo9BTU6j2m8dN4jwW8Mr+Rck=
X-Gm-Gg: Acq92OGygNYfDtctJ6deM9T1dE7Nko9eyi6JqUHc62GeTd911WV/O1X3YksOymm44GW
	TWCDcuEAxLVjzNEVtAlZdDhqiDmzawertJepI1cOPGzwjEbOcnyi4cjjVHT8wqkPlVW5RQTUW+W
	E0qWIsA2EKLV02g62I/47s0tZHn3CvXAaygNC99rA+2IsXyPtIGvzP7XIJwjGfcACE9Pb/bjtkU
	HtG4Yh2hyVuArTP0SX20lq2CCGXzz4XvTIJY00uiTdoNDeOzvaVrhjQ6GhSPhyZymEVY23TIZeV
	rL8/HQoM4W+QKo5EeolrUZ3ddxUEMFFF46PYFdu8QsO2HKXuibdCbn3tvCOyFbfBUeoQG7YKBBZ
	gKgils4rhFH0asLVP1MMT+xkS/p4ovj9YXcSx7/hCqDfzYpfluIes2BVjE17WqvWYi+0OxQbDiO
	W9d4CGtdi1Q7eL4jf221D7mH1lpb4=
X-Received: by 2002:a05:7300:a484:b0:2f2:6dde:df53 with SMTP id 5a478bee46e88-304eb0de7dcmr80296eec.17.1780001945711;
        Thu, 28 May 2026 13:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304e99788fcsm267308eec.27.2026.05.28.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29_/tmp/kc?=
 =?utf-8?q?i/linux/include/linux/bio-integrity=2Eh=3A101=3A12=3A_error=3A_?=
 =?utf-8?q?=E2=80=98bio=5Fi=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 28 May 2026 20:59:05 -0000
Message-ID: <178000194462.7095.15995482615675110714@330cfa3079ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-256414-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,linux.dev:email,kernelci.org:url,kernelci.org:email,kernelci.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 940475FA388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 /tmp/kci/linux/include/linux/bio-integrity.h:101:12: error: ‘bio_integrity_map_user’ defined but not used [-Werror=unused-function] in block/bdev.o (block/bdev.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:cdfa63349825643480a3af9641da66b9e0f22d71
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  97928cc88900a9fb07a4dddbd1db19eb0ce55c56


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
                 from /tmp/kci/linux/block/bdev.c:15:
/tmp/kci/linux/include/linux/bio-integrity.h:101:12: error: ‘bio_integrity_map_user’ defined but not used [-Werror=unused-function]
  101 | static int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
      |            ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a189fb7ee38c2a863e3d09b

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a189fc5ee38c2a863e3d0ae


#kernelci issue maestro:cdfa63349825643480a3af9641da66b9e0f22d71

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

