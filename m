Return-Path: <stable+bounces-67492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290B395066E
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9189284D74
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A29719B3C6;
	Tue, 13 Aug 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWF9T/xI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647119AD71;
	Tue, 13 Aug 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555624; cv=none; b=PmoJrcT5nFqP2Zis/SSkC+R+TcjKwhzZt79CXWLgW4pPCFSSKxeGk+F+50XlBTwY0v06s9piKm3k6TF6NUB6KBl7DmyJgzjXzGCsTsnLtNJiaFsVA3w4W0wPBMmxekFKDQD0n0EGedSfJxhXR0jHKCLSDAQEqi5g3tPpl/OGkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555624; c=relaxed/simple;
	bh=fITbtuklCwcsaCKDkShmi5DkAoTerFbU1OvG8olep4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBHbj1sveFWA0TBMTbKMISf6oJdjb/mQtH9UXcjmuO5UosoM12tkoGO6m62OZ5mfWpr7BJdKQxOVmuISdZVkmIYqnE8SUrlYtO5BC4UjW4qop/Kfh1aI+dO/h8UI/G9vT23915Anpj7bW3mPQotLy7qPJp2LhPLY3HDmL//1LJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWF9T/xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE48BC4AF0B;
	Tue, 13 Aug 2024 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723555624;
	bh=fITbtuklCwcsaCKDkShmi5DkAoTerFbU1OvG8olep4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWF9T/xI7V/NCOISreHzxWnyqPY30USDQWW7cfddP8gUDIy46Ycbtxq44HeTkxzqV
	 03c9ihFWJ9tdNCVtvwWxcQsw46eB9ztv8TtcWXgax9UEZvHW+6f723G2oP0hyszP0j
	 EQVTdGFEn3tl7Xi1arhBxeQrSwt7y+bwT672wFmFrflieZxsmZVYRa7IlCSa628NQ+
	 97KDFJpsHMUa29MsCbXC6LrjR/zZ5Wh9CgVrXyc0fBKOSj2ebAcM4DkNj4d05QERWv
	 fhoFVwlb1IgCYVYiyDpKBpTrrOejjf5ZMbu7/cKYUlHMmWG23upEO7RzV4l9NFdC2i
	 RNIHmlNv053Nw==
Date: Tue, 13 Aug 2024 15:26:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
	Igor Pylypiv <ipylypiv@google.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	stable@vger.kernel.org, Stephan Eisvogel <eisvogel@seitics.de>,
	Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Return sense data in descriptor format
 by default
Message-ID: <ZrtfIg174_vS58Wf@ryzen.lan>
References: <20240812151517.1162241-2-cassel@kernel.org>
 <ZrpXu_vfI-wpCFVc@ryzen.lan>
 <3d3beb8d-4c93-4eef-b3ee-c92eb9df9009@suse.de>
 <ZrsqSA7P30vss6b9@x1-carbon.wireless.wdc>
 <20240813121549.GB4559@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813121549.GB4559@lst.de>

On Tue, Aug 13, 2024 at 02:15:49PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 13, 2024 at 11:41:28AM +0200, Niklas Cassel wrote:
> > Perhaps we could re-visit this code to be spec compliant again in the
> > future (after the bad programs have been fixed).
> 
> I doubt it.  They are part of the core low-level userspace suite and
> even when they are fixed the old version will be around roughly forever.
> So I think we are (unfortunately) stuck here.

Agreed... even if it makes me a bit sad to intentionally not be spec
compliant...

Sent a patch that replaces the patch in $subject:
https://lore.kernel.org/linux-ide/20240813131900.1285842-2-cassel@kernel.org/T/#u


Kind regards,
Niklas

