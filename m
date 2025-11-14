Return-Path: <stable+bounces-194789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8CC5D052
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 13:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 289174E1B60
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1767F306B0D;
	Fri, 14 Nov 2025 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckQ4gPkM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FF2417F2;
	Fri, 14 Nov 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121931; cv=none; b=hWc2hvfbmsAPls0SCfeLWs1kNybaRpG2R1iBs54qxw6gdroqiNlfYeExhuZRyIS12sbiaP1onrjyE9g6YBqOe6KvXqDqePIx9PRbe1q7YRYhMobiOWBjC9OoctAL3Z1/LAP5FqaxoKGbKrPqUC9JZ5Lf86M9Z1YsVnmstwxjypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121931; c=relaxed/simple;
	bh=lnlVZ/YweDGt6v30pbzcUbJ0jebZXHQqpRcJeYAFSmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgSroFt+0vxozZcNHeyM3gz4zvXRM3sLpQevp7ARAolNiUO8kCkgGNJzwFQeI3gku00EvXdmsvaomfobswZBDzTAD4l1F84Q5c8iGsKkUm8SUC+OzHTBa3SEJ4A8enYzyzLVWXSfCdAotfU0lBGsyTT0tayCz8vsKFeSvxCsBIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckQ4gPkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BA9C4CEFB;
	Fri, 14 Nov 2025 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763121931;
	bh=lnlVZ/YweDGt6v30pbzcUbJ0jebZXHQqpRcJeYAFSmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckQ4gPkMrSmAP8VpSae/obKcQ0SyzSLDkMd3g4Dz/mvDXMRgukNGZLu6M3cvUvkcT
	 UmD2VmETag6bC8MEXhhw35tKbkXzMP2xIIEi8nX25G2Ae7jOLRLGe/Adv0GkxL5ZTg
	 Pglk+NM/EnCISr1vatNnejBfFIVyvSjlVHuPfz/b2VIoSCuy8wA7qbW2B0VTtQL15i
	 rZ4S7b6IGePCtjh5vsfqj/BTyiu2SntFtPemj+PK49+ZnU/swJA/22RuR7ORnhlDv9
	 SeUJyRl3keJr2nBCfP0erzrmooXEwdWBRld0xW+/2Ebl47wAb0OZl98ddtAa/anyHT
	 Hck+VL72rU0bg==
Date: Fri, 14 Nov 2025 12:05:27 +0000
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] atm/fore200e: Fix possible data race in
 fore200e_open()
Message-ID: <aRcbB5PekC9kR96d@horms.kernel.org>
References: <20250122023745.584995-1-2045gemini@gmail.com>
 <20250123071201.3d38d8f6@kernel.org>
 <CAOPYjvbqkDwMt-PdUOhQXQtZEBvryCjyQ3O1=TNtwrYWdhzb2g@mail.gmail.com>
 <CAOPYjvbEbrU6qOewg4Ddc8CBDjmXous=PbgFF+5cQHf98Jtftw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOPYjvbEbrU6qOewg4Ddc8CBDjmXous=PbgFF+5cQHf98Jtftw@mail.gmail.com>

On Tue, Nov 11, 2025 at 08:47:14PM +0800, Gui-Dong Han wrote:
> Hi Jakub and Simon,
> 
> I was organizing my emails and noticed this v2 patch from January.
> Simon kindly provided a "Reviewed-by" tag for it.
> 
> It seems this patch may have been overlooked and was not merged.
> I checked the current upstream tree, and the data race in
> fore200e_open() (accessing fore200e->available_cell_rate
> without the rate_mtx lock in the error path) still exists.
> 
> Could you please take another look and consider this patch for merging?

Hi,

January was a long time ago, so I guess this slipped through the cracks somehow.

I would suggest reposting it to have it considered for merging.
I'd also explicitly target the patch at net. Something like this:

Subject: [PATCH REPOST net v2] ...

And feel free to include my Reviewed-by tag.

