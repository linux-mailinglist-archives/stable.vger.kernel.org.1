Return-Path: <stable+bounces-134710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D122A9434D
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1423189AC78
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F11D5AC0;
	Sat, 19 Apr 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJX3k5h+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0C1B4244
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063456; cv=none; b=HLWAOkWEKBVyMsFqCqiySUkhz0br5Xs6RCsQdtL3AOuIO+dKEowaeMDCwd/DuHnKsRfSBeK/16OsfZ7hR5n+LGjYxxxboQDFsltxo/c7F+vNKoasbXQAOF28QXmIEkhfFKEW4G/eqEFf0YCqbfP505lMWvmNIw5L4v2WBRm0bzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063456; c=relaxed/simple;
	bh=zbC5SGjNYtOPKTTJb/KZ1VNLJ21SleZxQ/+in2+Boz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF1Qxx6PAtQ5eFn8eH1Ei01K4SKwLtd/n06/zBrmqwoihIolg1bZXvZeHAAzJP0Ite9joGvFt3A1HiCap7XA3C7aI7E7qcr8f/GOGCD2Nu7CQtiwvPY7XVXp2fwwRfymgLRmBOwrRRrTcjKzPlMpwHW/V0HafvoTWs1+IcaJiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJX3k5h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BF5C4CEE7;
	Sat, 19 Apr 2025 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063455;
	bh=zbC5SGjNYtOPKTTJb/KZ1VNLJ21SleZxQ/+in2+Boz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJX3k5h+i+zvOGKQKNjC4+KxonIVyWOPMA6dpHcux4pT0pHjtmYng9chtQOL+TCyc
	 jdVN85BxzKDm6IcadzVGlAbTxB4xLm8G3BmsReKeXi3XXBlBd4fVl0TnDDkQcMCSqF
	 vY/9ml/RKLAXrHQSBXsKE/hiJlfY2Nel70xH+5F796IkPNSOV0An3CT2FlcEh0oqhP
	 0tnxetC/2JHLMXlvW087ZmwSINhIRjFIqR909pncYSo6KtUxAoCRPHjollcCAweGnN
	 kDovq3RDSZEb0kdV+bL1pxWSex9y1U5+QqhlPPvdAnTk0jbcHojKze5FtVLIrac0dr
	 uGpzQzr3Rud0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Sat, 19 Apr 2025 07:50:54 -0400
Message-Id: <20250418195947-01aa7b86247144d3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418120552.2019616-1-hayashi.kunihiko@socionext.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: f6cb7828c8e17520d4f5afb416515d3fae1af9a9

Status in newer kernel trees:
6.14.y | Present (different SHA1: 501ef7ee1f76)
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f6cb7828c8e17 < -:  ------------- misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
-:  ------------- > 1:  cd70e36c3c1e3 misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

