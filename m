Return-Path: <stable+bounces-109192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F478A12FA5
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A1A1888228
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0928C1E;
	Thu, 16 Jan 2025 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKff76Mz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A65579EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987148; cv=none; b=j+g+fnw7LvsjMjsVJJZ6zUqPnNBYaFINTxc+ZxlqYdTE7WtiTPr0M0qPmkp2zk12PbGAWp1BolYpcfMqPX9Gw5dDntG3QinXSlNFlc7LnFvdCai4LzBTaT7Iq4gYquKNtBCqDAaYp46YeWv1/rK2wGRPBEQu5CCwFuBTKqBQ7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987148; c=relaxed/simple;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QwL0jjJAvSBHzZEqi1UbJQ20k52xNOoev4ZonyTbeTdzg6NwwasVGI7pVK2NdlU2EqY2mfFT3fgrpJ3Q7EWTbYW4TOrpSw6tOvCIpYx/MNyrjBY16vniNAb6f95lKYp9Hh/PosFPWK/j5wJ244y6LwzDGj2+YbWfH3Z+oVuSG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKff76Mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760EFC4CED1;
	Thu, 16 Jan 2025 00:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987147;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKff76MzcsCijVPGogMTFImuSD5bbFRenWIp2b83J+1qkYSNZ6if0TXRmO76QJCqv
	 nHxMvAWF++vYdzQTjW4KMyXaGalG8gh0YGyIUuvhsTq5Vf4kvQ+jX/aWK7BpislZoN
	 glY6QOoH12tEMLmNL0NfY+NNPIECCK3i5KmvGDOyFTsIVzoDVH1xeJLC5mymO+Ld3H
	 KOVDmF36szgi7ul6v0Hs0KeZtNuqQUpyMur6HdSByPgBO8dQo6mC/2EAbi0yomJ7si
	 Nf6NzsvE6UZSB7db+JtvbGj6MaazTO6/+s4cRBmIonPvAPPHhI/TI8tzkqCN6W8eIj
	 4T17QD8SI/5Yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] regmap: fix wrong backport
Date: Wed, 15 Jan 2025 19:25:42 -0500
Message-Id: <20250115154550-ba82828ccbf25142@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115033244.2540522-1-tzungbi@kernel.org>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

