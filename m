Return-Path: <stable+bounces-197008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD2C89AFE
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E33A1C78
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E602EA172;
	Wed, 26 Nov 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAXU9bOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460911A23B9
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158845; cv=none; b=EOtFPfIOUH7Cn1FZbgla/GucKTaKFwiv9CkFyfFISNCmT1qB7q40X1kgnPcAb3ujCUNqxjLXwKjA63oMKAuWBB1Hw7qWCBEO70IXk0G/trnK4zbetRYnAqnOAa7sfM8ZxWtUy5bkkCf85SIJMj5aRDiVEd2n8uSpqFYxrzcCY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158845; c=relaxed/simple;
	bh=bJKqR3y8UP0/z5/KFd1BIynLtbgaAXiVuXUleUENs6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOStJ5QRIRORA+kZGPGkXFP/2CHTlkQDmv57ynyqd8HzeE2pcwfZsbTW55KNA8qcZtnyU7LKPRTumWf/tl+oodkwNNZo439r+TSKIGEM4vJ1Eoo3cWKqJyGtk2PuPQJ3Ff0DImmyDsoVItXD6DWMhM25o7rBoYRRTzWgrCB4u0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAXU9bOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2393BC113D0;
	Wed, 26 Nov 2025 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764158844;
	bh=bJKqR3y8UP0/z5/KFd1BIynLtbgaAXiVuXUleUENs6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAXU9bOGSMgd4s8gIsx2fZQEb7MYsRBMppGRljF9Lzc5sRCIJp9gPnxT/2AVONx0E
	 YMMWRuxeUG7s0e39Qj+YjMMqbucxyapzeuCuOAU1E2ynW/DbKkjPblsQC2RfFBTs2U
	 gwyZFP2F75u+mky9vWIgcMACSPTqUa1lo2EA7bxWK1w+0QtDv3sE3CRw8rJ2o/fufQ
	 2I5AqmuxPzixcRYgJWf0N7WQDA1Hg3fs+8u2K3akQQcv21x8AbnBtpigRXuesaM3rt
	 PaWqa49A0/J/bs/I/DNMIy1niJro8HYnBlJmNHLp/isPaP9lN+vjr+xN9bh43o54MY
	 ZGzz42yOXZ1FQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: stable@vger.kernel.org,
	Koen Koning <koen.koning@intel.com>,
	Peter Senna Tschudin <peter.senna@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 6.12.y] drm/xe: Prevent BIT() overflow when handling invalid prefetch region
Date: Wed, 26 Nov 2025 07:07:22 -0500
Message-ID: <20251126120722.1357962-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124222827.901507-2-shuicheng.lin@intel.com>
References: <20251124222827.901507-2-shuicheng.lin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.12 stable tree.

Subject: drm/xe: Prevent BIT() overflow when handling invalid prefetch region
Queue: 6.12

Thanks for the backport!

