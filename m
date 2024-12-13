Return-Path: <stable+bounces-104109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB3E9F1088
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5E01631B9
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953C1E1A33;
	Fri, 13 Dec 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyDhblSO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBF1E105B
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102781; cv=none; b=ioeuF9CWo4czIOcYsWGUYzeoSPwPSn4otEzjLMYYerUIo2Mk8VqjzTeFLh/YlSZmCeHBQVX/bB5C37OU4NEFxiFf+cmwVFc5p77EyobFe+RIvqQFWAYePXulK90XJUneDWtU2TTFwEmJDQv9dI519c4oCmmsApA+uaWDruVat7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102781; c=relaxed/simple;
	bh=zHbciDMYElQslFU7AuaxM0GHiWo0vnzdTzzzA9w0YWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjntdHzqQs3Bn4OYkX6xs1LfIOnvNGcWVLJrxjyjQdlFhLNd3TnSgsqmjo5Q9DFc/tuawoEC84cGE1EY6ZZrJslEVu436YVkqYz2lSD2F0JF3vas1LJm5CiNx9VecNDj9nvA5KCtnRa4dDK8f9TX/DlndnGjuE6D5YxfWyZfO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyDhblSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA09C4CED0;
	Fri, 13 Dec 2024 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102781;
	bh=zHbciDMYElQslFU7AuaxM0GHiWo0vnzdTzzzA9w0YWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyDhblSOsjCuDBQZdT/SyuSP3LKyiZ5dEQM8tC1D4jRxccEo9f040NU2X58fOMWUk
	 mQ0fwqxYhbIl4dwpkU6Yiqr1J+Rg/lZzLgxuRiL2E/SNqUbjfKnirqZZZTMjFdMVh5
	 EOaoy+L/f3sDnCdGR9okqmFFf8I2vvvjXdA+G+wmVOGbLJ8Ia7iROtM73D0lvW14Vu
	 5/z0+RJXPfhjgF3MyvOTS6w9OmYRMOBp/+0t8MlY42ggLKqxUl4PUjKrBt2Zriw187
	 bNBOcQR7UKhxcU497RCNccxARZ7ahlfwYQjbyE2tk8se3Croztkup0RPgy7rrOHYPA
	 wR/1sqrMU73JA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 resubmit 1/3] dt-bindings: net: fec: add pps channel property
Date: Fri, 13 Dec 2024 10:12:56 -0500
Message-ID: <20241213094943-225243067e2420ca@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213112926.44468-2-csokas.bence@prolan.hu>
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
6.12.y | Present (different SHA1: e8139c66df98)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a ! 1:  0a9ae16b34ceb dt-bindings: net: fec: add pps channel property
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
| stable/linux-6.6.y        |  Success    |  Success   |

