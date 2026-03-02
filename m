Return-Path: <stable+bounces-222669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKyKNwbQpWm1GwAAu9opvQ
	(envelope-from <stable+bounces-222669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:59:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F641DE280
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFDAE3049956
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABD33EBF28;
	Mon,  2 Mar 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PbE6AEB4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBB2DC334
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474347; cv=none; b=OaDpRaWm+baufg/DC5zjn9QjMhAjQp9AB5t4ceq36ABke+1gOKSiiVO0r1fr86IAg5R4skpphsFfgeQsAGTnN9MxSI51WI6+WwlAR+HlRWMLiA+WMF2rBCEdfmIm81dw8UHM+tVRJfhaTLjdSrvtkpEyGbwIMiDlQBgFmb7meW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474347; c=relaxed/simple;
	bh=1w5Vlz/pRXhw85SP64cTE+3DlnzHFU2vtzKRQzyXPa4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gbppJFvJQsMnS2gO7ZtqUQwhWROUnfnRd/Ph4v3M4vrlTv/6EoHrml7BLecX7KyLaLDlo8QQPt9labHrkUdWdTPnxTH1wlBQrZC0o8TYzZl9EvyWXtJKYbNJFMr/uOCQOAQJYeXCRbnii/pe+CZVI4wqgKzkfc/PuuQL8RbL+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=PbE6AEB4; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1274204434bso3854062c88.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1772474345; x=1773079145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw2lqhDaQu318BXVhIilQRgAQgQ1GqnXSYWH0OTsSsU=;
        b=PbE6AEB4Eslc5ybacs7IaLYg8F0NFkeSZEsz724GprscdHYuHgEy+Uepz44pcjUsaW
         acZmwKnCobi1WwudP9TLxw5VWufDn1z3oVIowB3g8AbbTplc0dDxii95YDn2VrT5zQ84
         4H289HpjehvrztvFCiFufEElpLIld36ZgQifAzY9IXsh5tcUlF27LQ8gbkuGsezuBMoI
         f3WsuMMhEpmpU4e0q22mg184gD1Rzi4Qr/olAftsyVFq8/FlcoMUhFzOuv8PxG9D62I5
         qWmDhGAVWO48k1PU17i8Tpl8CXZArCMTFAhuDfAf6hlEltfJjd/pq9in4hjeYJk38HqY
         XTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474345; x=1773079145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cw2lqhDaQu318BXVhIilQRgAQgQ1GqnXSYWH0OTsSsU=;
        b=P1P4+NN0HVVPYee+JGZk4t133HDc8lGcNKid5nhaE0hpl2ubhJV2lDrgOOd1xTMkQL
         ewvTzi53OpWmK8ROW/R8LSfMaRBSa7eAL8I7touR4FZPFnMo1AEu+lutL7aJLsTmoXUO
         XzYblm4uWNawi9+zeFKYvfeXVruKKveadSGeu1wKzCFOJNw5kxctdCPbDMA4S7pgZu44
         qdoZbqLtpF+u4y+97RuggMSxhXUk/g8fkJIuNF6ypjjqhSui6vj9+8WkAfsPiObBt1Iq
         Xa/qc40xHwjW2XJqOSeCacfEFQLzj0i+0NOXs0cSLKctx2CimI7seCKYRDh4dJ0pCcOn
         Mb1A==
X-Forwarded-Encrypted: i=1; AJvYcCULqT1fDTldZN1YahCs9AG8kriZ8EKDtbmt2SIKgE/Q+nb0K7qJHM1pZNSNlwm+SnLGhsObl3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzat/qXJjdbsfaGxkVRIFgL6eY1h1rteedJDKElLybxqWLg3tVf
	tF463TunTVeER14e9Zo0GKoalAuJQPSGKrThnkmwxAdNgckUeSQwnwCL31uWHwWiF25huld/v/v
	9MFSQ
X-Gm-Gg: ATEYQzzraOtwliHIJKLj421UPKlAR39eI3kUcOAkmGTaWwm9vfJrjAwFdu8GGGBttEq
	hFIX600CEMPVl9vA9YV3UptWTW5T97oTmky5c1JcMEbayQpR/X7Ghzql0vbk9y+A1utJRa3hPf/
	5SHXcdB2CCltx/N25QWLEhAdsauBu2y/AxPNhHSQm77QXoxLF5B1iU/9aNv3JgCHlNPBBf2LsiS
	P0mMkNBhtMSYxvTbev46D9JFf+mq7tUTr5KEnaP3s/W2iYBDOkRz+NBkKaZVMaXihY6rYrwj8K1
	GOLsRjp4qG4j4mCE+CgolKzHWQIxCVC8dS/nN7wy9G/UjE98Z7WjISt+WyCYklAML4ZXWUs4GXi
	ZkfrmtXPOwvmnynwOJ3ay9/73i12eZdsOiqZ61be6WsiHmBPFbo8HzcBZbYafIL6JMnMy/g+Ye+
	0PO1srqjXBw7xCyfNX
X-Received: by 2002:a05:7022:ea28:b0:11b:2a5:3b9b with SMTP id a92af1059eb24-1278f79ef34mr4625762c88.8.1772474344568;
        Mon, 02 Mar 2026 09:59:04 -0800 (PST)
Received: from 2959ed5fe7ad ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df391sm17210424c88.5.2026.03.02.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) variable 'link' is
 uninitialized
 when used here [-Werror,-Wuniniti...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 02 Mar 2026 17:59:03 -0000
Message-ID: <177247434334.71.16254114449455051283@2959ed5fe7ad>
X-Rspamd-Queue-Id: 39F641DE280
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-x86-kselftest-69a5bd297136242fe3918225/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222669-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,lists.linux.dev:replyto,kernelci.org:url,kernelci.org:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 variable 'link' is uninitialized when used here [-Werror,-Wuninitialized] in drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.o (drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d998f4a1bdfe1da7e6b814583709b9ac2ecf92bc
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  e6906aa7f5ea74831bc56d675e1173abf4d1d5a8


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c:532:3: error: variable 'link' is uninitialized when used here [-Werror,-Wuninitialized]
  532 |                 link->phy_state.symclk_ref_cnts.otg = 0;
      |                 ^~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c:507:22: note: initialize the variable 'link' to silence this warning
  507 |         struct dc_link *link;
      |                             ^
      |                              = NULL
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-kselftest-69a5bd297136242fe3918225/.config
- dashboard: https://d.kernelci.org/build/maestro:69a5bd297136242fe3918225


#kernelci issue maestro:d998f4a1bdfe1da7e6b814583709b9ac2ecf92bc

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

