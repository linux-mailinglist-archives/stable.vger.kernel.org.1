Return-Path: <stable+bounces-70351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A8960B0E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F64B23716
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333401BC093;
	Tue, 27 Aug 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdYb5kMR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D01BBBF9
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763009; cv=none; b=u6EY2NaZ+iqO6oQx1yMp50EEkfF2UDDcSPmprS+iw1I57idfyQypiwNYUeFXZ8KCi7bHYFCXPpFqFDeLr0UrLETRPWqrKnsWXlGGEOvlZ0JxfNw3RCEQcb9KYOUMh3ZW85kNum+dcKicovA5YELaSXrzPxFW+4SUfg3nssxlNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763009; c=relaxed/simple;
	bh=TnAWP2yMCJzhj0VD1iOATi4eGsN7d2enyX58VNV1sFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q92ax3RlaxxSJ3TaACzVDOu7Xkcj/sQ+19saIVhkBI5SE6KJ2L2XmROh91r5Qvs7N/3SkwHIKvUVuWK5ccUSIp0g7J9hjX6rz6eybdDXOOt6JdCL2GO7hSw+A30zctjqvI49xOdXoqRSFcO+ChTAd7j6ve4vnGlftGFA7HOsqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdYb5kMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA034C6106D;
	Tue, 27 Aug 2024 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724763008;
	bh=TnAWP2yMCJzhj0VD1iOATi4eGsN7d2enyX58VNV1sFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdYb5kMRAgMccyxjpsOR63npkG2pU5LvJcx5vQOFv9U8c8VDMoiuKupRY1aHRQ57u
	 BLIi7pFfbt7FWivv8hyeQQp2H7EuEn/Ds5CLr3LBpgkagDwrXo/ZQrUkuHsgNT8SAO
	 omqXlzg03TH+5sfERvdIvFtbklLic8kVdntYLwaU=
Date: Tue, 27 Aug 2024 14:50:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: stfrench@microsoft.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ksmbd: fix race condition between
 destroy_previous_session()" failed to apply to 6.6-stable tree
Message-ID: <2024082756-ecosystem-hazard-fd1b@gregkh>
References: <2024082626-succulent-engraver-73cd@gregkh>
 <CAKYAXd_j19G31-3TAC0gBiDtgWentYpRAA9oc_wZ0T+Q6s3T0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd_j19G31-3TAC0gBiDtgWentYpRAA9oc_wZ0T+Q6s3T0w@mail.gmail.com>

On Tue, Aug 27, 2024 at 11:30:15AM +0900, Namjae Jeon wrote:
> On Mon, Aug 26, 2024 at 8:57 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> Hi Greg,
> 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> Could you please apply the attached backport patch for linux 6.6 stable kernel ?

Now applied, thanks.

greg k-h

