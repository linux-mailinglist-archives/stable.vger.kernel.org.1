Return-Path: <stable+bounces-182004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A3BAAED8
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 03:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F63818892E1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 01:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF11F3FED;
	Tue, 30 Sep 2025 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6zjdaU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A13198E91;
	Tue, 30 Sep 2025 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197241; cv=none; b=XG56cfbR/EZImsnepzazWNw/b4u4wQsSnfC7rtpp8xmsed0Z0UPAaFbZ0HtiereYER+8e+7d5vNmV6YZ7tyxMKeEpcIfa3ML3MgCZ/aVmxQSWh6uT1iOlpOF9Od6oyU6H3nW8Czm4b06NFc3ZvG9j3I3cKQrnqoU7dsgtcQC5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197241; c=relaxed/simple;
	bh=muBamWiTIYdMP7HkhLMKf5sLN2ERObGUPzxJURO8caY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tD1AtGonSH+7x1WLkiRkkeEMFVguHdBTLuJTE5yzKqmafAMOFh3g+xdR7QpVYfY37xTnSH+ASqJivlf4sn9PbDXOlLLnBI/ZqVlr5X6WA8SsGYFbRc/Ka0LEnD+7lWdsS3nulz9Wl2TpMnrBcp8exk9LoP1g9LW3K+H0jO3rc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6zjdaU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93413C4CEF4;
	Tue, 30 Sep 2025 01:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197241;
	bh=muBamWiTIYdMP7HkhLMKf5sLN2ERObGUPzxJURO8caY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i6zjdaU52iWprb9gEf9nHOjqo77jcJnvwI7ST1L9dUExwLBtQr4WdCfu0HT+IUqh8
	 ivKvIn0eMk0suyLyzu0mExubHjv9UTYPgzgqmIJ1kdF/ueC+1AaAkfE2jPUiNkEPEe
	 vXjUXxsNGO6B+o20hE5q6PAqHRGKiXGkwROip5WWbLY1YmTRYOg4S6VzsuhrHnWHEA
	 PqF0dlZfFO+P7tJTcbSlw4jF3Bzs1wPPs/9okmKXPTf3pYSizsWnlLEIjdcrkHCvV/
	 0mUFjH7tH7N9pEZSxFM3bic5WXU2Yavvp4RPJiMBsbW+v1pCIqJ+Tx/wx10h4Lo3pS
	 RvU/WnFLnwg3Q==
Date: Mon, 29 Sep 2025 18:53:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bo Sun <bo@mboxify.com>
Cc: Simon Horman <horms@kernel.org>, sgoutham@marvell.com,
 gakula@marvell.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] octeontx2-vf: fix bitmap leak
Message-ID: <20250929185359.52e3f120@kernel.org>
In-Reply-To: <0bb6cec0e6bcf22a43bfff4b0813b201@mboxify.com>
References: <20250927071505.915905-1-bo@mboxify.com>
	<20250927071505.915905-2-bo@mboxify.com>
	<aNpbZkQZxa3HkrJj@horms.kernel.org>
	<0bb6cec0e6bcf22a43bfff4b0813b201@mboxify.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Sep 2025 22:49:54 +0800 Bo Sun wrote:
> I=E2=80=99ll resend v2 for the net tree with the correct subject prefix.

Since you promised a v2 - could you also make sure you CC the people
who signed off on the bad change? get_maintainer will point them out.
Unless you know their address will bounce, in which case please mention
that in the cover letter.

