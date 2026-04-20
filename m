Return-Path: <stable+bounces-239952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDNIHRJf5mndvQEAu9opvQ
	(envelope-from <stable+bounces-239952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:14:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE02C430CEB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4ABF1314A592
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14168379EF0;
	Mon, 20 Apr 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="fP3/g52q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D9379EF6
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704348; cv=none; b=Roumc3DpkIReyKsBQTZ/J7cEXWsWnwJJjtR4xTm9gRFD3YgDIDcaYeroO9nJhByNY2iqOS4QJxnzkQ3B7CzQSjlTBRKhBI+SGiu+c8N/KgOgoPFujkPLeYYsUktzA/gbmL0HYJ2pOkP2NJ3J1Lpq3KTy8CTLBS6IaEKHLGSfNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704348; c=relaxed/simple;
	bh=TEefBO/jfFzhHQIwHzKAcQWZUTxz/LZvyBaas0QcKIE=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=LD9CAtEXgrqN3tMmMqTWGAwdKqopp/aWfUVIkHfdVnXYpCveNRztn/TjoQz7G1sx0hXLFRSaeuZRIamomItsivDBgreSJcrcZKPxebQzLRutc/aFdhYWtK3CIqfJZ4nWPEEXqKQ4iiDERotJhJ1FGVd7e+Rg8s5uKL4EBRSEIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=fP3/g52q; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2d9916deb14so5901334eec.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1776704347; x=1777309147; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9eGzzhh0FAmUr/DDMXs3EvfoY5U+zV/xD+dkaQq4yY=;
        b=fP3/g52q5CtZZCSNEdiDxhT0mVSuF8L1mVC8WS4udDkNn+ZEooUNuj9WgPcMzEXlXC
         zP473eY4usBubj1h8jBBRRWIXfWBOFCgst/zjnu1sAT0dzJVDufAZknY8rzHR5GbePJZ
         YUtJKrjoiZPpiZSioZWwLBZTdmSoA3+sM55fuJpWEQNXYqhYNK1GGIEFM5A3sVWQvUjq
         m3pqDkVFCWE7V2MeFaflNctpeXSwnbNCvuWM4FJ9N0N1l4NX5rWtyqvPgjbLTy34eoSN
         iTrVpfA3ZO3M+E8TDvor4Ab/4dEj+I0p4W0BlApOehDFg/bYWPPrhvb/OjcAvDYjknVr
         eo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776704347; x=1777309147;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9eGzzhh0FAmUr/DDMXs3EvfoY5U+zV/xD+dkaQq4yY=;
        b=bB+4dXUSutaL2jj9RqN0Pv/pNbgYm0n9BDbR9Mquhd0y9nVFSgs5lPsTz8U2xZ5mLF
         ybxC19AHuHi5/TpjKVcTTBgxz9MtLh4q++VRbgwoGHK7N7JgYG2VplQUq6uY5gw3Zdg6
         /hojayTvMviJRdskA8Mpg++yTHeLWgNcpmdpkFKtjmLytyMI/t/QczHncC5gHvkOqbZU
         wOHpr7uukv6RIUbcotL43F9iZwfQj7YpGaZUYTlkc8CicbHzf+pfgOlgoCTj+mrJce4F
         SZ5j6/5tjLJqmg8EWvcwCPGWe+c/GMjV5jv8vfd0WBcsqetTtdDcSAn8Efo31SIyHTgg
         CrYQ==
X-Forwarded-Encrypted: i=1; AFNElJ84yAv3DnjHUwKPBXI/4fizvSq2h5ebSVzKDE/P1Zve3+YWnhdTGPJ31vTIMiq1kwzqQEXFT2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4faEY9CwHHRJ9whPQEAezQ6DdZV5h0pXHpQadcexK5rN29Yj
	ZFBrs480Gi7ORr0QVKNGZQ7dksxSJCpiX02nQ1/f0r+39lBS9LoHcIDs50Nx5NokM6o=
X-Gm-Gg: AeBDievfs8Buw2f2QGSVvKscQ2bgURadHKTjJqTsD3myofi+IByfkjE/oyDHvazx0t4
	wKgXd9b1oQaEPWFZ5q12cHCY77UWLIohTphynPAW2DlgmDaMnx8yuM5B+8qSVAVbT5Rdt1/B+NM
	RmRZqnrtq7XLNMOsAbV4VNU4zmOTlhigtQCOWJLzm9Y9qQqR1Ze8n1qWEaL4H7s/v5cltQL94Gg
	20oPtoW1w39q5OowyTXYEpVgLkrZ3EiyNP3BB/JLH0sm3yzU4L42l+yrUqg2TJGCTiQuPvE4Gn8
	malFNzknmAA0lHqc9ya/DYim7jqg1zLwc0Xnz9tU0RBOgg9HlG6cBJeJjsOWwHQqlB1b5+MGLXU
	o74Cx9QEy66y1tNSSJOKM0ivU5Jryi31PePp2Gmiahw2jKxZo0xqTxkdP0SRHoqS51cL31ZATRe
	13k9n1pQaBZFN4ztxgAHQqUTLe7wk=
X-Received: by 2002:a05:7301:1014:b0:2dd:5641:ef2 with SMTP id 5a478bee46e88-2e47a6d317amr7894562eec.25.1776704346841;
        Mon, 20 Apr 2026 09:59:06 -0700 (PDT)
Received: from ab39070dab57 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfef3sm14535213eec.24.2026.04.20.09.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)
 /tmp/kci/linux/include/linux/srcutiny.h:14:10: fatal error: linux/...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 20 Apr 2026 16:59:05 -0000
Message-ID: <177670434558.62.9827956402441148770@ab39070dab57>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239952-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernelci.org:email,kernelci.org:dkim,kernelci.org:url]
X-Rspamd-Queue-Id: EE02C430CEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 /tmp/kci/linux/include/linux/srcutiny.h:14:10: fatal error: linux/irq_work_types.h: No such file or directory in arch/x86/kernel/asm-offsets.s (arch/x86/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:75a5e09670a0a597ae668dabfcb220dbbab35b49
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9e25ab7f025ddef199e4671e927f4995209b5dfd


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
                 from /tmp/kci/linux/arch/x86/kernel/asm-offsets.c:9:
/tmp/kci/linux/include/linux/srcutiny.h:14:10: fatal error: linux/irq_work_types.h: No such file or directory
   14 | #include <linux/irq_work_types.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

=====================================================


# Builds where the incident occurred:

## allnoconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69e657769b5a968309e8c3f5

## tinyconfig+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69e6560a9b5a968309e8c249


#kernelci issue maestro:75a5e09670a0a597ae668dabfcb220dbbab35b49

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

