Return-Path: <stable+bounces-193002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B4C49DCB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E34C3A5C4D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D21C5496;
	Tue, 11 Nov 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="coYVcdd7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDE1C3F36;
	Tue, 11 Nov 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820757; cv=none; b=AX3r9PcnvFuD/Li4LPSYT5klkKNHCMIlgvu4Eee9ICt8ana677ddz96u6cclYZfvSSU2bKqSr2qycvWzk/8oHBigiElM3YtjiSEXqgPYIGwX/TgIIKe/JhO1An+z7Elkv7FubXRg6NKDmLpavjxUY+mE2XFPRfP7lQla0cYu7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820757; c=relaxed/simple;
	bh=tmEynDFT0iU/lwP8EzIKQPTUdOo4aqJRs8fz2HYpXaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfMXJJUKvX2UuavB3FbpvI1BTgFzu65p8TutmahiFaOnDGgPbniXuc1MDZvHaqxkF+7wZk7DIJ7GrmVvZqKoZy3H63F7h74tnf5LDk/R7q5+pc6dYS20E4v4gjCP4uxsXBCoJVxAhMx72sQpstcgl2QNSdQuwunGY7L4gyKI3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=coYVcdd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BF3C116B1;
	Tue, 11 Nov 2025 00:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762820757;
	bh=tmEynDFT0iU/lwP8EzIKQPTUdOo4aqJRs8fz2HYpXaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coYVcdd7qsKsMWhd0kwnOzRCnfWDEpVpb7GGBkb/jYomYONU+KIsLwVkB6LyzAg3J
	 W4LBZdrnT06knHMAfdmC2Iyum0Ib55+Zo1v3vCVr9gclu8IN2An1d8eOzIikvv93+W
	 15MUtmuFVYsr0aop1rEOf0O+oe7OmKQukpDrvJO4=
Date: Tue, 11 Nov 2025 09:25:54 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Melissa Wen <mwen@igalia.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: Patch "drm/amd/display: change dc stream color settings only in
 atomic commit" has been added to the 6.17-stable tree
Message-ID: <2025111144-debrief-engraver-056b@gregkh>
References: <20251104235338.370388-1-sashal@kernel.org>
 <3aaf35bc-3595-45af-bd20-aaa5c9401959@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3aaf35bc-3595-45af-bd20-aaa5c9401959@igalia.com>

On Thu, Nov 06, 2025 at 10:17:16AM -0300, Melissa Wen wrote:
> Hi Sasha,
> 
> Same here, can you backport the previous related commit (2f9c63883730
> "drm/amd/display: update color on atomic commit time" [1])  too?
> Otherwise, the commit below alone will cause regressions.

Now done, thanks.

greg k-h

