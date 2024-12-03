Return-Path: <stable+bounces-98147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2F29E2A7C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437581634BD
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2811FA840;
	Tue,  3 Dec 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+XNlYRF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6AB1F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249594; cv=none; b=FdO3S+QxhRyf56OUt+XJQFWcwvEdRPlAv4KwO97S8W+VU3Cv0wjr7NO0vUQQ3Fc+y1pJztYLGvB07sql25HI0UEP770bUjfwwYK4vxDyK4nWSJBevcYWF41g3N6a3jXLO6jG4MIwkuMYXFkrKHW1RbNscLLwjJlpjrUmQzI/fbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249594; c=relaxed/simple;
	bh=iTQYfzlBVcn8FTkoZtXJMnk+w1pLD4LBi/jmwkqg9tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2rG/Xkq/hEaeNj66BgVrd3t8uG9eu/y3Na3QGqit3mCO9+sUxIsXKO1cWTh2Q473F17U1czDPW3OnvVI6wbfgLKzsH/+VmoKDP3Ux61JUDmjoVh/xNJi0SPr1B7mIST12mf+WHD50PxT6bXq+sFZxOJ4RLqd7yLGmWXPNdQgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+XNlYRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2C1C4CECF;
	Tue,  3 Dec 2024 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249594;
	bh=iTQYfzlBVcn8FTkoZtXJMnk+w1pLD4LBi/jmwkqg9tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+XNlYRFzAo2ZjPj1xSZra64ZE/X5wY3o6Y9s1f9OZizULWh9um0pnGkWImwF9XoP
	 zcFSU1D84BIh2WTuZaWBCrs1rwwW1/yTvtL3hFcb+NGfQD1IQHqZlDlkQqKFlwCcuD
	 9coAB65u7P48aeewLrpVGiVZLpiJFy7ix0cBBaOIVUXSPozvNXqY5Kg4lKFVnMKAn6
	 GBvrwKswNxUsDSTaQMV9hVjpltrZJVME9dIK0c9DerMPBbC0KruA+9VgD1L9a7sUx3
	 jK0k6iY9BO7ifjoWEnz8tzIrZyML99HyvC/elpJpKKDG9sNyiNg4HzZEVXSIQyT0xj
	 p/Lqs0447E/9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v4 1/3] dt-bindings: net: fec: add pps channel property
Date: Tue,  3 Dec 2024 13:13:12 -0500
Message-ID: <20241203125924-a9c20bdace5514d1@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203141600.3600561-2-csokas.bence@prolan.hu>
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
1:  1aa772be0444a ! 1:  70f6c6c8d7cfb dt-bindings: net: fec: add pps channel property
    @@ Commit message
         Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
         Acked-by: Conor Dooley <conor.dooley@microchip.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
    +    Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
     
      ## Documentation/devicetree/bindings/net/fsl,fec.yaml ##
     @@ Documentation/devicetree/bindings/net/fsl,fec.yaml: properties:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

