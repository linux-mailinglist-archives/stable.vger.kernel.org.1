Return-Path: <stable+bounces-211170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFSYN8E8cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:53:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B87F5DA45
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BB38A6E9A4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C081E3DA7DD;
	Wed, 21 Jan 2026 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="pOK7Bmwa"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222F3D647F
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025552; cv=none; b=FOKnKByavV5+A1Tikb01XAUX0zyS1YuD8UlSvLcwUuXhIrUaUocxTkq6/qS01Mw26chAdflBxqDIj4dGt6/QsPbgkCxTb2CNIrd8tKkZMIhmglf0mmKEP8VTe2Lh7gdKog3ynWDBDugrW+zHdwb3XzaTVTiSbRIR6sXrBE0Cc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025552; c=relaxed/simple;
	bh=c+1fUVhimGOFaG1tidMCU+u2/KtHkLJFEtgG5xKF+V0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=GUzoBVTws5Pdi2v987oq39YCeAvkY0MZjTdBo0b1lwfpjDrSXU0qfJ80arnB6y9weG78k5r+r/e4jiclRNYo4KJ4k6wZluOVNrLhdYXHAfkpAujbMyd/7VDVQHuOg268rtO/gu1QdLnp6mq+3x9uECgAidYE5JydsPssj8z6r+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=pOK7Bmwa; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ae61424095so226683eec.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769025549; x=1769630349; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRJtCIjvNF/iUNbQSv0dvFkUt7asR6mfiBR+1isVk2M=;
        b=pOK7Bmwa0UWIC1d/5mvFJgsYzq/AyOvCycsBh2dJ6vNX1lsR3cjPaVBEXMRWibiK3Q
         d0UCmDnPsL6kXDfIpzL8XsdmWfAwcCZOKyqQ118vlnUxBhzJVt136AYG9djrQ2HiiV4C
         MFkC05QKJUk6mWCOZmbJ8vPhSZnGzbYq+A42dBZWn2ZdNBROQl1psl53jL2eZYh1/0F/
         fhBEVKwkrFMYf9AUjOaRhABHgT91ni7evOAwrq7O0S9fE/WIzLir1SghgCouEwHjy5kz
         IY9H7J2d9sNqDhXtxNtFdCVdlNUvnV8ARomUAzhXOLRMpCN6ln71vVhUcs+duAJMBzxG
         GN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025549; x=1769630349;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRJtCIjvNF/iUNbQSv0dvFkUt7asR6mfiBR+1isVk2M=;
        b=okaUml+t+ivxF8NT8VF3hodXHkhpldlk/QO8fz1fYbrEJWL/2ZSDjm/HNsykUTLKcU
         tK66TCW/57HexMedL/Vqxj2NjZCXLWvf/V5RO6bSqUnMijtYI3WKTmkhtN40scQx7UWg
         bW6JXQ5g9WCgsahVF2pUpuxFpHQnmudN7ezuCn1TYFrAOAdR7TQagl38fSJBaV4pTzWe
         lzYshDEV8hDe32OXtgVpRzf3q9a16+cnz1qO1cFNLveTsMxxwWFFNDlLJ1OL6Z9gxCHI
         DO0jo8V4FmwFQk9SNF++e/EEtSbmMCaHlFHkb+aUk5PsOrCrjuCGv5yf2DWvU5LngzUX
         M1mg==
X-Forwarded-Encrypted: i=1; AJvYcCUQyyy8XSFK/mNNh/eJ+Lz2IiJv7Jom4XWmZqgZfI0sgI1UrN5637wNWhgilpDOtvYVMWL9dJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/eboDIQ+AjSnJ2wK3bJdnyvJfyHJstsV8ijSoP2EHu+Scv1De
	xKorpJobXW13cMhhvAxbZT1gf1ezr09PSevO+Unt8AeUlvoRJJKBNz56vVugas0ZDN0=
X-Gm-Gg: AZuq6aLNuEJtRIj4iuSrrrDQyDxJZ+8jCK2awTPledugkkQJMw7PzZPBBW0/pGR6t0P
	fQIKGlZCTRaQUvgm/CuM6qgZ9LMprPkiE2vg/38AOf3fj6RgfVZunLzQmfy34k2xK4xfIkFp0oS
	2LRip9TWcn0QiSqqAThEEbT0/wB8ygFueG3o0B9XDhuwVy+ZHXIkZvxTPZQBMAdg8dupGpEUiUI
	NUinTK2bs8BURHAOroTqbT395Nv/q8QKgPiOWnnHWy4VW74t81s6izfsyutCuSw5XUwRuoRz5vQ
	x18FnisD87dBrASTDhRuXB8RdsKyWfVwzE3OqmMbafQVUPwJEIZWFZuO0Gmhb3BgL1seqf1EqTM
	yMUdG6WrOwrGHotFDf8u9HAgfOM1nDbCnsuQ3Ray//gW9xB5LHH+wXKv9+vGQnJVtwNXav6LjzP
	p2hHIY
X-Received: by 2002:a05:7301:168d:b0:2b7:19f2:6b70 with SMTP id 5a478bee46e88-2b719f26d3amr1202216eec.26.1769025548984;
        Wed, 21 Jan 2026 11:59:08 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7047b099bsm6562153eec.31.2026.01.21.11.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 11:59:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E1=2Ey=3A_=28build=29_unused_v?=
 =?utf-8?q?ariable_=E2=80=98atslave=E2=80=99_=5B-Wunused-variable=5D_in_driv?=
 =?utf-8?q?ers/dma/at=5Fhd=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 21 Jan 2026 19:59:08 -0000
Message-ID: <176902554784.564.9505833301479741321@22d5995788c3>
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-gcc-14-arm-multi_v7_defconfig-69711944b2a19cc73abf20e8/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211170-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,kernelci-org.20230601.gappssmtp.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email,kernelci.org:email,kernelci.org:url]
X-Rspamd-Queue-Id: 5B87F5DA45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 unused variable ‘atslave’ [-Wunused-variable] in drivers/dma/at_hdmac.o (drivers/dma/at_hdmac.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:eb513f17ca94f8bdc1ff36c448217b39e9cddac8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  48e9d0fb9fdb9a69863f2a421103e555511e3f16


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/dma/at_hdmac.c:1350:34: warning: unused variable ‘atslave’ [-Wunused-variable]
 1350 |         struct at_dma_slave     *atslave;
      |                                  ^~~~~~~
drivers/dma/at_hdmac.c: In function ‘atc_free_chan_resources’:
drivers/dma/at_hdmac.c:1610:9: error: ‘atslave’ undeclared (first use in this function)
 1610 |         atslave = chan->private;
      |         ^~~~~~~
drivers/dma/at_hdmac.c:1610:9: note: each undeclared identifier is reported only once for each function it appears in

=====================================================


# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-multi_v5_defconfig-6971193fb2a19cc73abf20e5/.config
- dashboard: https://d.kernelci.org/build/maestro:6971193fb2a19cc73abf20e5

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-multi_v7_defconfig-69711944b2a19cc73abf20e8/.config
- dashboard: https://d.kernelci.org/build/maestro:69711944b2a19cc73abf20e8


#kernelci issue maestro:eb513f17ca94f8bdc1ff36c448217b39e9cddac8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

