Return-Path: <stable+bounces-233947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oECnCWCJ1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:59:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 877743BF356
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 704ED30117AB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D83B3C11;
	Wed,  8 Apr 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20251104.gappssmtp.com header.i=@kernelci-org.20251104.gappssmtp.com header.b="nY0WWy+c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179973D2FF5
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667547; cv=none; b=mAbkgFJcteOFi9BvX8MzYZGjvKqrOoXXr1r1j0PsaEs7B7tx31/kcbIbbre5VHz4JnhW4fGNxqn6CYQfATFSLKnODmHQylZOiCjUF94QQQLg0S6rhbh3lyMKBu1UC6uAXWqd73V2s7swWfhIPXa1c32qUojfINf8JsxXzz3PyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667547; c=relaxed/simple;
	bh=7Is9niZOYw90fbs5iBQgouXWE8lUyrdDc7RpJ4pT8Cw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=tyhrcstnh5LCllxpZH8100IJz02INOtpzk6MAilpjBLqeG66TtuMYOpFJg8Jo+4IEs+ukqqorEe2yWaazAglLc+xuOJn7mc3ghrOBoXav1Oe0qm7TwqYuGfk/EVCuxsncV1G1+p1FNDx54fKCNq+5dmyE9AZScC14cMmp8g9Pjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20251104.gappssmtp.com header.i=@kernelci-org.20251104.gappssmtp.com header.b=nY0WWy+c; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d90833cacso76906a91.2
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20251104.gappssmtp.com; s=20251104; t=1775667545; x=1776272345; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pkK+wBH0RyZ5hbNOsE+Id6MaTrTEbdjXq3gqbBjbP0=;
        b=nY0WWy+cb50peifxt4HAZW5Vm0vRKZ4Y5ToFBYno3Os50KeY0OLu0olmMvMPOc6N2K
         aJrXMd9SlbRI4x8qzuxcfcCA0W4t/rp0vVr8YArotLTmWah/uA/xEGlv6YuPgUALMGVZ
         S616vu9g25QyLvlEcPl93Hs0txlgs9lPykX3gCgws2rttBuc2s9yuKWQZh0Afyq0s+vJ
         086vGEXkaTctBG5w3u1RV4d4JkOugIw+acj3eOsiehb3Cl8DtWSur9hNsqSvpS5p3AkU
         cJrnUanRmIgxcuqLTbF8gaBZcHbMe9RH6X6FRrtGxK9AOc7rn9wNI4FfiTcn5IP7q69g
         ByMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667545; x=1776272345;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pkK+wBH0RyZ5hbNOsE+Id6MaTrTEbdjXq3gqbBjbP0=;
        b=JiaAeFoYl7Wap+yTPt1xT6opMnul5uoDUIzUltQ8h8w8Ap6U9LHhZG+BgZmKBoCggE
         ggeZSCziR1C/b88rP12bdM3u+DNIPMdWSE25/cpf6Gq9iEr0/qisCBotjpdDJl4cX/2F
         5wZOyV1ks8/Kvc600xn54HWnHIZcRPqHHTkkt1Bm9BpTgWHXy2H/epTdGN5eQUjXtRw/
         4MrgXj607Lfpy3gjoFoViGxBX1Go2UYdYoqQOO5rQsljam8wxNms3Tuv6O0Mo2t1Ipdq
         AJ3zIFEW4Hxhm/57vTzTpx3MSQks3siMpCsx9Catlrx8k0w22cLc0tHj7ohHS0pYlZhw
         JYzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyGYEVCv2ktTS3MNglAe74TU/8mksAH992fENnqF62VxP4zltLQjdPBlAUr4sigml05PPBb3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFJq5CjuoBCmCEg8mywswTUbFQ10X/r0NQwcm+GTu8f6FTLm1
	bMFviHXzClLzRssRki0GiXi5ua5z/BJAp5Gmw74CMFYEWkoj2GUmdXON5CTlOyibLAw=
X-Gm-Gg: AeBDiesrAK8GPh3eUiTBHDM9F64hyMd+lTbKH8VeE8n92M+vLxokSrosyyQnK9bdDrB
	Cr7WL8zXuJTO442KstxdoHNCBU902DgXSc1riS92681el1rChoTVYAIlQekVhjIDw+WqPcIqp7A
	ml78drpxQrSC+hkJ75lOApuxWh5mkBXdcEsMlKn3ue3+43gJH+MgYtjVW2vA1gXXDYbXRGwX+np
	QIdySBKM4ICw7iNPrV4lNN9mcGDb1rbR30lvDgd9HS8CwsMCr4usxnXjC1kZeWad5xgVkUssjeg
	pSlG1Lpl/QUfesnADejxYcr2wi3y41SIy+m7/n3O5ZrfVzhmTCUdAb2Q+6SqWTV/dFbRjfT9ABx
	iAU8CY/9QoiV5MmNFPERXuv9nCYznWfV71scp1zpYpaj1veQE19QzKufvES4gZTUAKxXLfeo5om
	zc3bAaGiVPgU1LFsNL
X-Received: by 2002:a05:7300:dc8d:b0:2c5:3b87:2ffb with SMTP id 5a478bee46e88-2d40c4044c4mr191587eec.13.1775667545297;
        Wed, 08 Apr 2026 09:59:05 -0700 (PDT)
Received: from 8692ffc4d55e ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c3010e9sm27312100eec.14.2026.04.08.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build) call to undeclared
 function
 'kzalloc_objs'; ISO C99 and later do n...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 08 Apr 2026 16:59:04 -0000
Message-ID: <177566754406.2914.15286976792443675323@8692ffc4d55e>
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69d66b9b86a2e63970e0ff81/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233947-lists,stable=lfdr.de];
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
	DKIM_TRACE(0.00)[kernelci-org.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernelci.org:email,kernelci.org:url]
X-Rspamd-Queue-Id: 877743BF356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.18.y:

---
 call to undeclared function 'kzalloc_objs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in arch/x86/platform/geode/geode-common.o (arch/x86/platform/geode/geode-common.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5dd9f5f0b9adc292f80f57c79c18fcdde9d721d7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  889594f153091ca04fb0c019a17098b44a4dfc87


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
arch/x86/platform/geode/geode-common.c:132:14: error: call to undeclared function 'kzalloc_objs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  132 |         gpio_refs = kzalloc_objs(*gpio_refs, n_leds);
      |                     ^
arch/x86/platform/geode/geode-common.c:132:12: error: incompatible integer to pointer conversion assigning to 'struct software_node_ref_args *' from 'int' [-Wint-conversion]
  132 |         gpio_refs = kzalloc_objs(*gpio_refs, n_leds);
      |                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69d66b9b86a2e63970e0ff81/.config
- dashboard: https://d.kernelci.org/build/maestro:69d66b9b86a2e63970e0ff81


#kernelci issue maestro:5dd9f5f0b9adc292f80f57c79c18fcdde9d721d7

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

