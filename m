Return-Path: <stable+bounces-96133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF39E0C13
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1193EB47373
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFD1D9A6E;
	Mon,  2 Dec 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evZ8UEDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A51D79BE
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158641; cv=none; b=d+BSiLJIs9XnlU8DxHCmjjpRIXlXyqFTA16qAXpvo1iKGJCY8KoTZtZ09vvKnnkmjnRQimUO9zX5lokUblASY77LuseyQAEJBMqLbeW6xVsSjtO13QoWmXEXU9mP8BwggRnXNtzQGVNy4seQaqhNWkHo6ozFvD6z4HvxDsFdGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158641; c=relaxed/simple;
	bh=dZ/ISJvxumIYpARGZyMYceBZDX+qwk/r6iOga1i3MrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0XcGI9iW/o/bonWj6muWZwngv6hOVO1/WXnr/3ASCLXIRUGCuqvfHsQcPqADMAV9g3zU7xEeJcEOH24PkSFwSwwhLSokUTzCDOKssv8aAh0S5R1S9Ao1cO/JzenJNwxxtgS1WgWXzf5r8TTcP3mWTsmxK2JAKnPSPzmgptCXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evZ8UEDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F584C4CED2;
	Mon,  2 Dec 2024 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158641;
	bh=dZ/ISJvxumIYpARGZyMYceBZDX+qwk/r6iOga1i3MrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evZ8UEDX62xJDCoPVXbjkItlB47kJtfBKw7VYtsuapZ1gZKV6wFzXd2CgVA6B+b1a
	 yzDsfwLSzhXOnEf8uHWsmdZs9wFZhs6xN+keKLeeZwspBchFM0Jh3jb6H/S1eY22qM
	 MVdUZmq6rNuBiF002e5uU0KnOlA0RBumWBClHTNxp6APLrsc/GsAIO3JxIS/0wNkAE
	 1/u1eUF1jIX+lBiXF04B3x920RaOicVVLpRdZ1iFOWeidM9ZmlcFnRAe0BrJv8BV2J
	 4Vb/Kkoda5VUgRdx8sSO3h4jJujH5EzNqrn8kQTqAhQ3/q2QqpZKg7fC6wnsLEtkI0
	 xlFGklDApz65Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon,  2 Dec 2024 11:57:19 -0500
Message-ID: <20241202104256-4f496c12fb83446f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202130733.3464870-2-csokas.bence@prolan.hu>
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
1:  1aa772be0444a ! 1:  e9fb01540921d dt-bindings: net: fec: add pps channel property
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

