Return-Path: <stable+bounces-128912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712BA7FBA7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DBD44117D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508CD267F72;
	Tue,  8 Apr 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0WB7Vnn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E7264A7F;
	Tue,  8 Apr 2025 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107406; cv=none; b=VS6cNcy8daL3mFRyO/YatyqgLOHsLBZgUhGTTAbflwO++oNMqE1CUi667Wl7mQzBNYsNL0g3LaKoFxtdduiq5gyYkBIw6Q/Q9+xTGULmkI40FJYXKJ5wtHPEqAbXhHtfzNRTuNmdmMPfgVpVSNQILYSeheYgmbm5V/20p9RYcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107406; c=relaxed/simple;
	bh=GM94/DwbdeD/EixIRO4/7Qdl2Fn77Hgpz80fPy0XYZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpBebmYPnitthvaGoW6HTQOSz1rORLEd5EV88qF643x1CLnu+dZWcCDFuSmJyFF14lAIu8mLpiOqLcmjIJo1OIgYDeMMv9KdMA8JSzrK62zUMJAkbeilgmY/hXktTqeq6fcYij7X4UbP+2VwVuJWLHrTel3vl5aYi5rHIUy9PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0WB7Vnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21B4C4CEE5;
	Tue,  8 Apr 2025 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744107405;
	bh=GM94/DwbdeD/EixIRO4/7Qdl2Fn77Hgpz80fPy0XYZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0WB7Vnnprhfns88GDgxgpthJobuwLuqlaEkuGIFU4sbnXzucIzlv00Zh22CPiNnX
	 izPgm+NK894+RgTEMf3jVH3dTZEsG9Ro5IX/yyFwm1LD3UBkuSkKTP3kOMspIywCzN
	 /zTaBaeJzzp1waztcCE/LELFYzjYvmV8ckFH+lCv3sTjMbaXaqjcHptINT1QC/Ux/F
	 uD1W3j7/PijrcpnziAwaiAoCJEUbiXvcsQrbdZ2poyJnQ52vOBZocVIFupxH8IR9C1
	 e8X+H97OV9m1lPDNchMHJI994xq07R5/jCkAqKNN1aVzexr7J9wdGc+QyhkY89MeVA
	 vU5fCuD9sC+1w==
Date: Tue, 8 Apr 2025 11:16:40 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v2] sfc: Propagate the return value of
 devlink_info_serial_number_put()
Message-ID: <20250408101640.GV395307@horms.kernel.org>
References: <20250407131110.2394-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407131110.2394-1-vulab@iscas.ac.cn>

+ Alejandro

On Mon, Apr 07, 2025 at 09:11:10PM +0800, Wentao Liang wrote:
> The function efx_devlink_info_board_cfg() calls the function
> devlink_info_serial_number_put(), but does not check its return
> value.
> 
> Return the error code if either the devlink_info_serial_number_put()
> or the efx_mcdi_get_board_cfg() fails.The control flow of the code is
> changed a little bit to simplify the code. The functionality of the
> code remain the same.
> 
> Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
> Cc: stable@vger.kernel.org # v6.3+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Hi Wentao,

In his review of v1 Edward Cree said:

  "Looking at the rest of the file, all the calls to
    devlink_info_*_put() in this driver ignore the return value, not
    just this one.  I think this may have been an intentional decision
    to only report errors in getting the info from FW, which seems
    reasonable to me.
  "If not, then all the calls need fixing, not just this one.
    CCing Alejandro, original author of this code, for his opinion.

I have CCed Aljandro on this email to see if he can help.
And in any case, I think we need to come to a consensus on
Ed's point before moving forwards with this patch.

-- 
pw-bot: changes-requested

