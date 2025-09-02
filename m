Return-Path: <stable+bounces-176943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85354B3F7F1
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA751696D8
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A872E88B9;
	Tue,  2 Sep 2025 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uELCpRfG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA32E1F1F;
	Tue,  2 Sep 2025 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800685; cv=none; b=j7BZldHfVN9VZ5OOBnUv1C78t7BxRLq3apkGZ4FCzho5tTYBUSgpmwk6w6AJBHVZ9QX5qTVH7/GEDg7HsAhgykhZ1rEklTFiONBH0QkslNg29BkAO9ggR9JSQfSM1jhWM/DZu9x+65cJSKk9gKAu+LMyrmcix0oKlRNq7tkDvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800685; c=relaxed/simple;
	bh=vh4/FHOj7ZBXNiCvadTvcOZQL4IQkTmE7XUF7mWr1sA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NZFroFTkTKEiSkhkqUA+mtbbkzO20nDEIEUBuZ9qnWb9Ne9PTnzv0qNPHIN9+mTxcVgr4SsBwR8aKNQQkDqubYAFpY7UVC9g2wY6CGy1MZly+N1iKYlJ6hEq++3ui2QuMglOZJ2lk/NJRPLbno7g1savWlvOrZ8+aJfMdmLW80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uELCpRfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0005C4CEED;
	Tue,  2 Sep 2025 08:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756800684;
	bh=vh4/FHOj7ZBXNiCvadTvcOZQL4IQkTmE7XUF7mWr1sA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uELCpRfGYOa1ghXXowTzldVI+zpZ1HHd7jbxZcL/trEJO7MgG+Fo9zMfKMnu1Jo27
	 kjspA0PUTZWEiAtEezlErZ+5a5fqESUUeTnXmC0xrrSIwn4XJnCEXNecKBvOGfnF2q
	 MCSWHyvGUfWFmnbaGelT6nvWL96BP39/IgHCmO37fJEe0KGFMV2X7z4K/Zo6PCBS7R
	 SK/zvZEPEYnyOelv/Yabgg9gIOBdIOIsfoGTnoOMd59kTnwJQG/J8WYhMeGF7Kv3BM
	 utvG0JSRUp80HaBnRyBLrKrvRweqmaJpL3cM1OBoj3nwaOYhz5qUMQ8+PPzVMfK5X0
	 M+Y2aGwzkxOjA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250804133240.312383-1-hansg@kernel.org>
References: <20250804133240.312383-1-hansg@kernel.org>
Subject: Re: (subset) [PATCH v3] mfd: intel_soc_pmic_chtdc_ti: Set
 use_single_read regmap_config flag
Message-Id: <175680068346.2182540.12191567209948802532.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 09:11:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Mon, 04 Aug 2025 15:32:40 +0200, Hans de Goede wrote:
> Testing has shown that reading multiple registers at once (for 10-bit
> ADC values) does not work. Set the use_single_read regmap_config flag
> to make regmap split these for us.
> 
> This should fix temperature opregion accesses done by
> drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
> the upcoming drivers for the ADC and battery MFD cells.
> 
> [...]

Applied, thanks!

[1/1] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
      commit: 0bcf2a8dd86b4bc610cc2d31784e36dd643c90a0

--
Lee Jones [李琼斯]


