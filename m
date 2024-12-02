Return-Path: <stable+bounces-96131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EF69E0BC1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857FCB36AFF
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9181D9A7F;
	Mon,  2 Dec 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMWLGJxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B21D9A63
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158637; cv=none; b=AORnHmvjiA4hOJlsi8qk/sSzqocubDsRzc1lJKI69Q8DcFY0EF+rsAuG4zvC1Qpoj0Ix3g1lYLLXuXE0HczvJLo1tl9T23zkkLlE2Z4Et3/y2fpIxVhBFx+cGO5NL9tkILViScIC9LaxqC+Qlu6ZgfolKnjlU/wgmcPPQPyt9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158637; c=relaxed/simple;
	bh=GyKrVEe32pp/yIDG7rZxfMkFMYhaArmZKB8FiXRSvPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1XgEItKa67USIlONOPfN+YEbswl8dQ33PImZ7IGdWVtb281tGUzIRmLdMbXkw0CZHgGNmSZ53iJ4jQfwlW09OVw+Oon08Nc/YMy3eXZ/Xo32CBFaofQtOWfGShAO3kaLmutb9ud1cMFv9/uL+SWu6vQ4jv+ha3+NT0OwPwJaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMWLGJxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68132C4CED1;
	Mon,  2 Dec 2024 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158636;
	bh=GyKrVEe32pp/yIDG7rZxfMkFMYhaArmZKB8FiXRSvPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMWLGJxh2Hc+mjBZL/BEnrYZXZ8R+V1NFd66h8NW5I/76WahJve7Hh0GU5N7nJ/hx
	 mfFt3OAf5CkAkCXzkJ+MZUiQw58CeFyBzh8oGZag7+1DgkEFwo+6niZMsypDc6m+QJ
	 79/P33swc/Cp4Q2ChqIItknY132LJAP54nFl7aljaxgdmysYKXhptC2QxFYN2AaZDz
	 IPpY0jZWOeuDVToEfko7mxfG9Y8kzCr4AnGPz4fm712eO8hR/zUIExwYodrF4WPy7z
	 14++kshgIF8+0bqVKZpL88GAinij1iYMLLjQih6VFXSHK4DFcn8P+BQX6kbG/WYjD1
	 Gph/JjncyI9Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v2 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon,  2 Dec 2024 11:57:15 -0500
Message-ID: <20241202112128-c5f73c5785974da1@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202131025.3465318-2-csokas.bence@prolan.hu>
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

Found matching upstream commit: 1aa772be0444a2bd06957f6d31865e80e6ae4244

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a ! 1:  bd3ac9bb9aa4c dt-bindings: net: fec: add pps channel property
    @@ Commit message
         Acked-by: Conor Dooley <conor.dooley@microchip.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
    +
      ## Documentation/devicetree/bindings/net/fsl,fec.yaml ##
     @@ Documentation/devicetree/bindings/net/fsl,fec.yaml: properties:
          description:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

