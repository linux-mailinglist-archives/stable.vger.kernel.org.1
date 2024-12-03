Return-Path: <stable+bounces-98153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885FD9E2A83
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF65162716
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB05E1FA840;
	Tue,  3 Dec 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6JK7eSA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8D1F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249607; cv=none; b=rF4FSEc8T+QOpUHBGgD0Vlo6H/uo/XEgRP3j4OA2HwSKjfzJXX+4EEIUp/VMMOmTQDen9Y7hBhsuQWN5qW5r64caklGlW+szZfL87JLp6HoUfBfaQ2qE2NVtrp+zAY25cVBaU8w7+wN4tGiIhi9L3ROYkvJqL9r/iACFB2RczhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249607; c=relaxed/simple;
	bh=hxnUm/j0nhk6tjiUgYpCJgKggKo1qSZ4bYT3GQ9rZKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceENgyKR+IDTEqrp141HlOIu69ga7RruMhoHdk5/V/wx5TfUNADSuamD7apn9BTBqsFHqNgDecMVdeFfhLaDsxGGSXWhSrB1mATUxFZ36lPiEtX4cjYGpHoiEeetLuHxTxohFTxLrPtBXua7hhywu8GDjy4FnMOujIQ8uF8VW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6JK7eSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E120C4CECF;
	Tue,  3 Dec 2024 18:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249607;
	bh=hxnUm/j0nhk6tjiUgYpCJgKggKo1qSZ4bYT3GQ9rZKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6JK7eSAjF2QntXNFFiTqcj8Kc3gOBmh8q2HbIO0r9Sqgjmv4fu7XOOHBRIWL/712
	 d3imy4GgnhCbJHdir/EygVjiJUbIkfLAyQt1jAZ3oW5xDIiy6Q5aac5rOTqnEAJhlK
	 J9HF8ei9RX+W6/WFIq7LNe57Ws9+kVVr5oDjBUrsAMrwdq504e+edWmT2tTdT140An
	 PIiJMUZ8P3+0vccU/Vy4DSYDt/kuS4KzAYvrHsF+b+QBWG+3Oy5XuuOWUJ3zz7JJFV
	 bu/hgWzMUG1atUsKDq0BzWkX8xm98oKTYnoT7pelJl8tk7CiK6nt1Vi13xA3THuxq/
	 fpXJ2ZotmlzmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v3 1/3] dt-bindings: net: fec: add pps channel property
Date: Tue,  3 Dec 2024 13:13:25 -0500
Message-ID: <20241202124104-7afaadbc4cd7d174@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155713.3564460-2-csokas.bence@prolan.hu>
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

Found matching upstream commit: 1aa772be0444a2bd06957f6d31865e80e6ae4244

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a ! 1:  15b5ce86bd18b dt-bindings: net: fec: add pps channel property
    @@ Commit message
         Acked-by: Conor Dooley <conor.dooley@microchip.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
    +    Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
    +
      ## Documentation/devicetree/bindings/net/fsl,fec.yaml ##
     @@ Documentation/devicetree/bindings/net/fsl,fec.yaml: properties:
          description:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

