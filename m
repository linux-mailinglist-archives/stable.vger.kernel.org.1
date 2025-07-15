Return-Path: <stable+bounces-161961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B036B0599D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6EA3B38B3
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19902DE202;
	Tue, 15 Jul 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rqV5OtT+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848012DCF72;
	Tue, 15 Jul 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752581248; cv=none; b=BdN7MhjC2/HXdred3Epz/vLRhhABPK5PilJ9UUdNmqF6JzOlK233gOMsZuHAixnOZMBowshoykh72T0GhTnjScIVoM0GP0frm4VFB63/k1qTTn7PYHfF2rFEuHKEKgTsoKMdfa5UZq6b1aPkeFEVaLLlZiCqsyuBpCsLNm9FSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752581248; c=relaxed/simple;
	bh=PfhqjWLGl8TfdAcGd8c8PWdu2VGfwYnF6DQ1sKIL6i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZg1wYStpK+gZcpUQol9m6Yk+AIXGnH6sZ2IOG+D1N6zf9Ato7QpPEkcfxdKGtxSbimiUsVPgN2w7ZYLomjERoY7QGcw8qH7Ow1SmqT82CL3Wr354jQ211Ulcl1KlT7iQPgeHs11c+yE6A9CXc6wNYkkfJWJfus+qGRHS5T+v+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rqV5OtT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC035C4CEE3;
	Tue, 15 Jul 2025 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752581248;
	bh=PfhqjWLGl8TfdAcGd8c8PWdu2VGfwYnF6DQ1sKIL6i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqV5OtT+pZXQdvAI5Gy5RKSwOnUmoLwi+4dRGH3fg8E2Tk4BvOjBnq6vLxIERjKB0
	 /h9lXEOKFBU1mP1tkpqd+rXscQ44ScC3WYA2LE5+wLjgs1sAiVstH/sGht21TI8GbV
	 gsZ4Ee6yp/lWE6S01U6yquiMwuh9QxJP3Qs+MOss=
Date: Tue, 15 Jul 2025 14:07:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Eggers <ceggers@arri.de>
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Patch "Bluetooth: HCI: Set extended advertising data
 synchronously" has been added to the 5.10-stable tree
Message-ID: <2025071537-bunkhouse-facedown-bcbe@gregkh>
References: <20250714173707.3545937-1-sashal@kernel.org>
 <5618464.E0xQCEvomI@n9w6sw14>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5618464.E0xQCEvomI@n9w6sw14>

On Mon, Jul 14, 2025 at 08:14:56PM +0200, Christian Eggers wrote:
> Hi Sasha,
> 
> the changes in hci_request.c look quite different from what I submitted for mainline
> (and also from the version for 6.6 LTS). Are you sure that everything went correctly?

Yeah, this looks really wrong, I'll go drop it from the 5.10 queue if
for no other reason than it's not included for 6.1.y and 5.15.y, and we
can't have that.

thanks,

greg k-h

