Return-Path: <stable+bounces-108585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19821A1042F
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 11:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2C9167CC3
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D4229621;
	Tue, 14 Jan 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W61Pukre"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843922960C;
	Tue, 14 Jan 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850716; cv=none; b=KqXkjLN93+xA8ySzAOH+IYrwHi/CjfvrPDFznEFIq9UlLHlyzpyNubchTxpfQNxKNsrnX50Wb6FC0UAgpKJXw6Sm1fXexF1spgA6STYUrsvsTB59I2pFC0V71b0LdEKjOH5+p3VejRD5slBZBQM3mD7uOWm310L2OtaO28j0Zr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850716; c=relaxed/simple;
	bh=8UPi0vddVVw37p3+WuEper/eN9MBNy4UApOzSD1VSeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PhpRbb6S3GbgimShCeFgbPG+woyoVpcMb2cHIyYXlyBSZRc8kVw87szpvdyR+d++lW0kso9pp0gDFQeXUfj99RuLPRmE8BuQ04PtYYHbcSBKgMIsLREMW5op9Iib/l0gqAzcGBH5rktwYMhjGoIat7otqQieeUMDY5a9NoV7JXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W61Pukre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C233C4CEDD;
	Tue, 14 Jan 2025 10:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736850715;
	bh=8UPi0vddVVw37p3+WuEper/eN9MBNy4UApOzSD1VSeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W61PukreYQiX4FL6fH3jx1n7+PO5QdpsABzoDYPCv5+eSoxoh7WFmJnBFK6ygAS95
	 pFcqSmOlkUyvf9QW88h64VK0bL/k7Bc5kbjXngg3oSheW2Cwi9XOJr/vfzqx0mZefo
	 VOmO1Wu5WAiFcci8MLjnpf5QntjKnoc7+X89zdhhVSaySpLqij1hsnYiu//myCQ5r+
	 tXEP/cNvai66O/OPyMgGWGdSH8J7fJiTGFfdWsCKZHG810UqayYafNjJTp6IX6igGZ
	 PGSMDk2RxNSxyqvjwTq69qsUpwr6txzh7rY+HfasPSCByk46P2JHCY4KVBDJI7E2KR
	 1/WP4KCXBOpzA==
From: Carlos Maiolino <cem@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, linux-xfs@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <173499428975.2382820.17644608915723809135.stg-ugh@frogsfrogsfrogs>
References: <20241223224906.GS6174@frogsfrogsfrogs>
 <173499428975.2382820.17644608915723809135.stg-ugh@frogsfrogsfrogs>
Subject: Re: [GIT PULL 4/5] xfs: realtime reverse-mapping support
Message-Id: <173685071415.121475.12319911889394164801.b4-ty@kernel.org>
Date: Tue, 14 Jan 2025 11:31:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 23 Dec 2024 15:18:31 -0800, Darrick J. Wong wrote:
> Please pull this branch with changes for xfs.
> 
> As usual, I did a test-merge with the main upstream branch as of a few
> minutes ago, and didn't see any conflicts.  Please let me know if you
> encounter any problems.
> 
> --D
> 
> [...]

Merged, thanks!

merge commit: 0d89af530c8c7591f75492e5814aa1ca4a0d26d7

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


