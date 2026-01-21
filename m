Return-Path: <stable+bounces-211149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JaBNNEjcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-211149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:06:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7F5BD42
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEB4250E786
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30E36214D;
	Wed, 21 Jan 2026 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="tcl/iqMe"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737EB356A01
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021947; cv=none; b=rGm2dHhyxqxB04VFa5l5xcJqqA3MxqL8CBAsQsC0/bGb5CNNvAu+CPPJtO4EOjJk5pWftUDkXv+NLfQsxUL/kbxqonXOHwxtmBRVyjsi8OHS/Ro6BN53P5csg1znE5wn3eevxWh35YJmPL1hdBd5WpOQ8lGBKnPThXQONI6sr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021947; c=relaxed/simple;
	bh=GxazzagfSvyaMFQnrje5GHcFk4OdxRIBlqlNTzyD0Qg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=N77eNnmykYGIWSsGx7E4px28azlPuVXkDbv0pmG/YWueaqVXIhCJ6zQN3GOdOu8vVpIJFv8YtfrKh11bgWnmXWhK4Rvc/BYydAls5UtHj2ayOFsisbmqnq15lEMG0YGk/BDpARNWVtryWpTgxzw18IRnUJJo0qndR3dOXcIjAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=tcl/iqMe; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b7070acfdcso157314eec.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769021944; x=1769626744; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SExM65zEEJHLPAkU8H6QaisZPKdwO4XLup74+914sI=;
        b=tcl/iqMeq5/7elEbukvNfDyZCG75oTn9hCR+6KDKCh14BRm1D5xm0sObIoTVoDa/Oh
         erKmRh5el9rtoOItdB0iEqtA+WguE38wHfSL7fLmYNEhRm8oHhP/nQVQ3Uaa3oAA1TD4
         gfLsYxSZYhOa662+kH269RjNbAYpwIaN6DGQ0aevrmpLpm5/9XIZkffqeeQ1RdgIWv2b
         pTuvVmI9mROOgUrTkXQevRSDgqvNj34jA0y8mEUDgUT431xGLIZ0A1UYIBn3R0A+dJIT
         rfzYN3s0OY2mC0zivDj013kYqpDb3KyHv8Nm7SNYCHWOWXA6GugvkP/s3znThQMZcC/j
         fPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021944; x=1769626744;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SExM65zEEJHLPAkU8H6QaisZPKdwO4XLup74+914sI=;
        b=bpBDUiXqmHDFBmuI0Zmd+G4xwz8wUr8OXghyaT5lgHnjdQKaCygKl+jHw62ftITavg
         O8mqWHew2Te39or/UzDSBU/+qDz42UOm0gN/dI3Gqwozzznznrj6zdeKJD0vLU6AASuL
         g3uKmwbHfra8IPCJL9QKozCi5Dem7S14++jqKrx4DpzBuuT4kW0O36JvMf+tNYZ5aHjX
         lKj98SO8CNHZVZIienK41EiweT822fdP9+B1A11hwTbrrHwAO6bDC9Avf/E8TzDiIHAW
         nQ3pD4dWZx/b8Ky1NN/n+QBxPOTkGmlLxQrmOUeGj0OWvnKPGqyc3p7525y433rM2aml
         hCmw==
X-Forwarded-Encrypted: i=1; AJvYcCXdssHS1TNLktTOOlThwbpWeit2rqfJLZ5L+stA1QmhrquK4P3sEmhcm/7ABksWsKm0F5Brrns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4E8uZR7tt7wqQljX6m/6bqH3oKA7XcUACa8BJVC0ZrAHYnxHq
	uTTcUDYC9B3wMr7oRDS1Q437AzmlxgIpoTJYIr39jMvCFPYYTf4Bcbpp8BA8UXasazw=
X-Gm-Gg: AZuq6aIpT32usAZ6gqqQxdJCDnmT/RPgP3L6oVq49MVqNWaV39azOnKSKdIrA4dPEb4
	17jY2hPlP7DLMqV/uJTLpNiYJDJNJkcC7C2LVELt5hjlto/biSVgD1XOUQO4HCLpihnduLesZgg
	ErkZZ3FgexKYjMEvK1KVeb37icmNwfmoP6xsy1pbuQ39U9FHpLs2Dfi8t6HSaoV+g0X/3HyFDmp
	2bH6qtbug5Ut7e4rb3bS30sUNBnHcA6R1pRjEjhsHYCGpYDWiPQaUT1IXkUQXos9tMqpxyTcmI8
	KJukCN3e9Wy808TwLaVturADEuWF5tLZpQZRnxfyXAPPAFWBV1jC5rnI2yJYShP2hmMcHZk86HJ
	069QojxCGGm87CsjJwf/daYE3dEQV31kwtCqIuqzfKOx8sxVIYrNuRxtsp0s511Gdi1t30uRkjy
	LftBwu
X-Received: by 2002:a05:7300:bc08:b0:2ae:5470:2e61 with SMTP id 5a478bee46e88-2b6b46c68e2mr14971823eec.2.1769021944298;
        Wed, 21 Jan 2026 10:59:04 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b712881482sm4088184eec.5.2026.01.21.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) unused variable 'atslave'
 [-Wunused-variable] in drivers/dma/at_hd...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Jan 2026 18:59:03 -0000
Message-ID: <176902194306.545.10475866485082828341@22d5995788c3>
X-Spamd-Result: default: False [0.04 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm-69711917b2a19cc73abf20c9/.config];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211149-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev]
X-Rspamd-Queue-Id: 31F7F5BD42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 unused variable 'atslave' [-Wunused-variable] in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:0360339307229420c256e2ad8f28644bf3796e8d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  48e9d0fb9fdb9a69863f2a421103e555511e3f16


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1350:23: warning: unused variable 'atslave' [-Wunused-variable]
 1350 |         struct at_dma_slave     *atslave;
      |                                  ^~~~~~~
drivers/dma/at_hdmac.c:1610:2: error: use of undeclared identifier 'atslave'
 1610 |         atslave = chan->private;
      |         ^~~~~~~
drivers/dma/at_hdmac.c:1611:6: error: use of undeclared identifier 'atslave'
 1611 |         if (atslave) {
      |             ^~~~~~~
drivers/dma/at_hdmac.c:1612:14: error: use of undeclared identifier 'atslave'
 1612 |                 put_device(atslave->dma_dev);
      |                            ^~~~~~~
drivers/dma/at_hdmac.c:1613:9: error: use of undeclared identifier 'atslave'
 1613 |                 kfree(atslave);
      |                       ^~~~~~~
1 warning and 4 errors generated.

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-69711917b2a19cc73abf20c9/.config
- dashboard: https://d.kernelci.org/build/maestro:69711917b2a19cc73abf20c9


#kernelci issue maestro:0360339307229420c256e2ad8f28644bf3796e8d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

