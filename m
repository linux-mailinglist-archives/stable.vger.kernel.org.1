Return-Path: <stable+bounces-40735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E08F8AF43F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7D028A766
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C518513B78A;
	Tue, 23 Apr 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IH4+hGY8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C361DFF9
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890107; cv=none; b=gKa2XHZErp3fe2Kotu7V+8zlnz1si8SKlQLMI2F+bkL2fy6K+pzcGDuP5WOvzLWKbwISnPf6cyKx0QjF/8Zbun5cVYBROItSYNz1zIGDTRBD8FCycOrD/um9BFgE7F7cSoIxpMe6zOYXAVeCvr2WwkBXGQcy7m+cC4jd8XJyjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890107; c=relaxed/simple;
	bh=/+e7uBmczqfEzM3NnGqHgCtGfpa2e9pPChJRiwNAikw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAsUn+cjcK5BkselwbvjC/X25CZo6lqb92n9IoB8m5WpcsAMcdP8BdLk4PRkv3j/waGL7nyS49zrE3b7MofHAlTmzc37SCYGrF+5BCPvrLhZaP/MFFgZ1aPD3cQhTjrfG2PB2qlDdvFnVe0wqkUv84SEE9bFVC/JfeNfRK3iNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IH4+hGY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1C5C116B1;
	Tue, 23 Apr 2024 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713890107;
	bh=/+e7uBmczqfEzM3NnGqHgCtGfpa2e9pPChJRiwNAikw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IH4+hGY84+OOaQTDCEbej0qRK9zehB81x7YgcU64adOaHyMdw2MBHKvTnk2f3+tK8
	 la+UXV4RmWughqnn0mm0z4RuoEtqKbfP778zYK03wBpCrxUnj8DMLaVQTpCzeQUHiv
	 Z9RqAmzMKV4u8BnGw1Tlv5HqifMtjBvRbim0/uj8=
Date: Tue, 23 Apr 2024 09:34:57 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, "stable@kernel.org" <stable@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-stable <stable@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 6.8.y] NFSD: fix endianness issue in nfsd4_encode_fattr4
Message-ID: <2024042342-comic-reverend-1dd5@gregkh>
References: <2024041908-sandblast-sullen-2eed@gregkh>
 <20240419160315.1835-1-cel@kernel.org>
 <2024042351-unfocused-respect-2dd2@gregkh>
 <70538016-22BC-4D71-8DBC-4832AB60E6BB@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70538016-22BC-4D71-8DBC-4832AB60E6BB@oracle.com>

On Tue, Apr 23, 2024 at 04:30:38PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 23, 2024, at 12:26 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Fri, Apr 19, 2024 at 12:03:15PM -0400, cel@kernel.org wrote:
> >> From: Vasily Gorbik <gor@linux.ibm.com>
> >> 
> >> [ Upstream commit 862bee84d77fa01cc8929656ae77781abf917863 ]
> > 
> > that commit is in 6.7, so why would we need to add it to 6.8?
> 
> Copy-paste error. Try f488138b526715c6d2568d7329c4477911be4210
> instead.

Can it be sent with the correct one so I don't have to hand-edit this?

thanks,

greg k-h

