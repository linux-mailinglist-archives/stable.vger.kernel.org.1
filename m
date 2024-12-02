Return-Path: <stable+bounces-96162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EB99E0BDA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE5E160FA2
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B71DE2A0;
	Mon,  2 Dec 2024 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnBGshbn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C45148826
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166974; cv=none; b=dK2wJmBPBtkT7tpRXxTp577OP9GBdlZWLfBQB/zwZuEyM6JuXhqt8lOiDg/XLV9wUDr1ne8T2wo2U2Sg+Qb04WM4+zyhqkxZuq9MeID4J59lDLP2GSAcLIVP5WrB1f7+xukek+oeerBX542IZ+Et7ug75Kw4kvM+QViNV3aiTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166974; c=relaxed/simple;
	bh=2JQfZEpVKXQfu6STVgU0gIkMgOhhmDV8yAYWxFc4uUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol1m4jDC2iq8UtccapmcbO6NIgzk1WqJezKHsjDoUwoUF1lI0vtDsRIwGr1+m3LTJnK1kbQ4TO4ZFtkZVMky4VlQjuPuEPe7HB/M7JBtSLA7kx0z4q3WIevW5AiGyPC/3XvDBx7vS2Fw0Eevmzk+titOF3L+V67fimGGRRI0ZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnBGshbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD0EC4CED1;
	Mon,  2 Dec 2024 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166973;
	bh=2JQfZEpVKXQfu6STVgU0gIkMgOhhmDV8yAYWxFc4uUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnBGshbnI2K1FLhtVUHN1o7/OOpNFwKxAbZLGhBnjDPo5ArY7ZZDqusqf020Acvh+
	 lA62Jje9z5xX1JZN91Zegsg0iwZrXLdwZ82B7e/p4AUAD5ZRyxg1NCbcrvk9KraVvh
	 isYd8KbQcsqRgn+VbMq+2a9w1GL7kTVA/WHiij0hW0xiklGIgu3rzAqtTmszyNVBNK
	 i52DsPS7eUJaEl5GqceGH5cm+tTwntZmvf95qRopU33GkZpuKt/YUyMqbao5y0q91f
	 QXhhdkVxe9hFHTBMpSoduPyoC1x3wAq0q6zkZZZiAhv4yjMnLm2n7G4ntNgMRGLYEX
	 5uSE82zEBZy3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v3 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon,  2 Dec 2024 14:16:11 -0500
Message-ID: <20241202130422-bb6b7d8bf77968a5@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155800.3564611-2-csokas.bence@prolan.hu>
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

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a ! 1:  a9e05f170d036 dt-bindings: net: fec: add pps channel property
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
| stable/linux-6.12.y       |  Success    |  Success   |

