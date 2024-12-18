Return-Path: <stable+bounces-105153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D709F65F7
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E307A277E
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5BC199FC5;
	Wed, 18 Dec 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D949vwL1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E519B5BE
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525252; cv=none; b=umUOC54MC8WzgHyMBVSppBxFbpnWKVl3BCcEwobiyUGfV0l2S9vKiHbIlA4x+DtoxQeLrGfD3Lr+tfBTFTjV0CdcJ/jb3aU5dF/xHJAGP4StNLzceMYRYGe5sDdR0tD77whR1dkmeSVcbnZLZfSQ64ZLk6bj7YIpwYZCZQenYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525252; c=relaxed/simple;
	bh=ZnuMlhPgO727QGZZHo90ROPQuFoxax87Y7dCX2Ri3lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5eOlSuSGcMqQ4GyxnixEmsJj05ZtoScEN8vhx89JSrPgQCRwMwZTNu9iCVDcLlEJfHgCoA/pbAdhUaVlXJdc3uDM1GjkV7Ae+wXOYp52EAjup4Ax/6ETZH1UKS9eBAc9jy97ivfU08PiwpQ3NAFoia7JtQCnE6qnZENHVdLfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D949vwL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1628C4CECE;
	Wed, 18 Dec 2024 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734525252;
	bh=ZnuMlhPgO727QGZZHo90ROPQuFoxax87Y7dCX2Ri3lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D949vwL1kRRL/S5KTHnz/VyW+2EbKlwtL1O/y36IcGYoARD7GFP7rPQ++EMWiO+W8
	 xCAxTsV3lH1Un351jw03SQlQ1FDOlhhU7Sj2DWz08sawuoN3cvBxlR7vkbsKDcrTEQ
	 65cwmTqZ30AaMVTHCjsSZENxFtUR7lzM8i824Uw7yuEeuZazCa+97Uo58aqE5JlVGa
	 fyfxALaXSFOgDcH9hmETGiR7iWC1EnGzJ+Aaj313l9SULuEsMht1nL9lrhTC9X6uvr
	 jQMqbr0azVR7aFpFDLVeX35xZ/Y9k10xdAtbRukhhLTLMvncpNhGLTN7p9R5bG3Ytt
	 2iXGOMCwmcd6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 2/2] erofs: fix incorrect symlink detection in fast symlink
Date: Wed, 18 Dec 2024 07:34:10 -0500
Message-Id: <20241218070337-58cdc18156fe72cc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218073938.459812-2-hsiangkao@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 9ed50b8231e37b1ae863f5dec8153b98d9f389b4


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0c9b52bfee0e)
6.1.y | Present (different SHA1: ec134c1855c8)
5.15.y | Not found
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...

interdiff error output:
/home/sasha/stable/mailbot.sh: line 525: interdiff: command not found
interdiff failed, falling back to standard diff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

