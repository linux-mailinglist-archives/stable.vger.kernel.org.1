Return-Path: <stable+bounces-239951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE41I5Jb5mkwvQEAu9opvQ
	(envelope-from <stable+bounces-239951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:00:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30164430597
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6ABE3004DEF
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717D37AA82;
	Mon, 20 Apr 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="gxAk8fkU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F522F5A13
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704347; cv=none; b=PlAYlIRh75h1R1Z6qF3PYx5BQrUWRUiuitO0kqoWhuhiCQ3Lsnx4617IRs0z4DVoxWhGYvaNuq0vnOz74mL7MxtbPkEtIanEma6bpo/aXf8QUlPBHRRSthEZLHdojbu9e727vsVqHEgSDLN4IAbppMy1DLSw6joZUwEpMRLm3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704347; c=relaxed/simple;
	bh=jfkjZaASSbH+JOyLiKBYHTV8WZvI+oW7XocjX9tKZ/I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=nOMSCsj5BXo7OP4Bl2HFKD+ZQR8wh//S0/3QJpJ+JkCuWZbjmuIxnFn0d2+UemIC5ZVsRHhnHhkGTRHkqVBnHCkLuwDBkleEK95BAQfUlbGYCrUb35E6xgVbmkUyuTgKKZhrNY8/EvYT3rppm9u2lVlBLPNvGDSU4KSM9hcHvzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=gxAk8fkU; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4377160eec.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1776704345; x=1777309145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucOF4lMLwQbLEDww/lYN0HIjR8xf276qTkjzUUUeCcY=;
        b=gxAk8fkU56ZDBMnA/3S+8CZ90ifnBTtR8HyxTQbXcNj6t+/y3FwvZ+Z4mPreXlxiNQ
         a5fOrh62ddq7Qyp/fZgdwPDKmfLSn8K9c/F/9qmisgduhGP33fB1fEpmyu2sOa5K5uDX
         unS6hgC0msyhSzq7jOD6RFTqWCXvMDH+Rgqw3nje3v55sTyq2XCAVa1KLARm97FWNgBE
         diTEqTXn/sdSHgNf8vG7rrhcmDOYiFpeFZ3drymK5qg0gzxlGw9YU5I5ox7LT+qNgz27
         2caVkuZhjpa6ZylAMjZS4kTe4rUSHekvugWffd90w7kYlFLq14HzoLvFXo8U9eoTak4C
         zI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776704345; x=1777309145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucOF4lMLwQbLEDww/lYN0HIjR8xf276qTkjzUUUeCcY=;
        b=SqHeuOZO6UfYe0A28ODyz1QXm6eztndQOWOVZzQyWTq4s08lGQ2az5mJg4sPWaBj56
         ndXPFBG4ZvXl/79IAoTcup/D3OtNhxJroXHNDOuTgnXNvN9ZU/rZezr4l7rj5fE6nw9j
         adSug82dGh3liGwc5BgUaE0avhReYMyEZG6eDM8kEqD6+bS1FhyqXu98iPN9/ZV80cj4
         BqAs/IYOXvWKDz+aBVinxi4aebBK0K8+Pl0Xgng7iiFGWWL+VgG/KeazlBhR/CV1TjoP
         jwq6qN0rxFJkL6oqmjMoy5Qnn5rVs1lII02ESS4gtjeX5b0U6JjCBQ6HcC1e5Wfg93RF
         lEKw==
X-Forwarded-Encrypted: i=1; AFNElJ8LO3PgfXp9PWt93s5cs1k++5lq/hxThxbNBk2zhAEY/zX8OqSoCs+lDwH/L/IK6iDa+CmQ0Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgUabxzVTfzdM3CmBXoUWaYrQnrApqZFco/kxAPgbg1nAAmQS
	Bje3gZeUH17BxvE+uYeYKeOD5c/GnaznJYoDRgTjw8kf0Ls3Ro4z/hPiYYrR5fAmt+M=
X-Gm-Gg: AeBDiesPq7MAH8YwSKySeopBbDMHwWk1bXJZz+ut1XWo73kbf0IZJOdYk+9a7u885q+
	Q/W1rOjETm3EL866vEg4jdUJcQNuXv7fSy5Eod8S5gMZl2h8AcpaS7SYu7Ih4BtZDoUPNsWFVrc
	NOjd1Pf6KbFhHV49IEn0jq9zGOCiIYpIchCF9UKZy8po1KoL1ULFJyVraNVBeX9j9aSekL3L0Bz
	qBAQYSf7v/Homs7cpHbyNlMvYxrFVdfSC734SfzvqfBop/kQNH8gY/sQRx+2BLEtZPzyo66UeiW
	oxnjcJ8NC2Sfj32KUr87Bej7/0TY566VgOte1ieJYD2U4fkLeWwCPsx25NnHflhxcs7s3dV9cs4
	CsvLph9doburyPznl07FmQErpesp7PS9escCN5bxodHeoY0tvkjrsd7d2arldr4pFjbgWQe8VYf
	z6sG41CsVutaM8/put3eNh65IvMTo=
X-Received: by 2002:a05:7301:1f06:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2e464dacd7cmr7575322eec.8.1776704345364;
        Mon, 20 Apr 2026 09:59:05 -0700 (PDT)
Received: from ab39070dab57 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfef3sm14535131eec.24.2026.04.20.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)
 ./include/linux/srcutiny.h:14:10:
 fatal error: linux/irq_work_type...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 20 Apr 2026 16:59:04 -0000
Message-ID: <177670434418.62.1731646261981143148@ab39070dab57>
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-gcc-14-i386-tinyconfig-69e655db9b5a968309e8c204/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239951-lists,stable=lfdr.de];
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
	DKIM_TRACE(0.00)[kernelci.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 30164430597
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 ./include/linux/srcutiny.h:14:10: fatal error: linux/irq_work_types.h: No such file or directory in arch/x86/kernel/asm-offsets.s (arch/x86/kernel/asm-offsets.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:caf41e7fff6ed39ff0dce2f987bfb823c82c5ef3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9e25ab7f025ddef199e4671e927f4995209b5dfd


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/srcutiny.h:14:10: fatal error: linux/irq_work_types.h: No such file or directory
   14 | #include <linux/irq_work_types.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

=====================================================


# Builds where the incident occurred:

## allnoconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-allnoconfig-69e6568d9b5a968309e8c2e2/.config
- dashboard: https://d.kernelci.org/build/maestro:69e6568d9b5a968309e8c2e2

## tinyconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-tinyconfig-69e655db9b5a968309e8c204/.config
- dashboard: https://d.kernelci.org/build/maestro:69e655db9b5a968309e8c204


#kernelci issue maestro:caf41e7fff6ed39ff0dce2f987bfb823c82c5ef3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

