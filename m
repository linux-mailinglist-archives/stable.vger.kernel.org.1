Return-Path: <stable+bounces-105395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F089F8D20
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 08:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02133188A357
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A017333D;
	Fri, 20 Dec 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2n+AdZ3K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D086337
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679152; cv=none; b=t+8IRFjFTxOust3oa6nSG5tgxjboi2ARYL9yRhgP4oNynBIJ+AkcEbUCz4H7niESzUl2HI7WMlWpjZHKlQgav91VwLCOoWOob3pqK7753Qa9nbSarjZ842vdItv0FFPe3UE19nmqmg511TVbXGlu6ALWVOPWEsvb/9poQKxPcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679152; c=relaxed/simple;
	bh=5d0HLJpsI+1Z3otP0OpgCzR3A2b+An0/MlEndTlqQ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JopTJPb+LJeKCYTbeVjeYDqHToqAZayRQ6PFHoE+749zO0heBclNwpGpUTLSvrRWydPcN/TjOtotow/XU+9jzeA3kKoNiRwBH3D5ClaQjKnzTJDI3L+iyphu6r95dm1Yn5cgBpZttq1xs+NhbEHwzG2hVegKEke2MwTIWVklbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2n+AdZ3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBAFC4CECD;
	Fri, 20 Dec 2024 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734679151;
	bh=5d0HLJpsI+1Z3otP0OpgCzR3A2b+An0/MlEndTlqQ10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2n+AdZ3KSekddZbfPU8EHx7jlJkyZca04jT5wMtzDHm9S4ft8iSGpga26aYgiBCx2
	 gqi0nTnmx8kH+5/Zn2fTpTtPoG3EcUR9J/TCdo+uRopvdKolYCeVf2mI1lWqKnopTK
	 HzWtzto86NpVVxmsNd9xDJICUenoRHaL2kiEcaQY=
Date: Fri, 20 Dec 2024 08:19:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "ccc194101@163.com" <ccc194101@163.com>
Cc: jpoimboe <jpoimboe@kernel.org>, peterz <peterz@infradead.org>,
	stable <stable@vger.kernel.org>,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs
 noreturns.
Message-ID: <2024122027-reexamine-wrist-fdbe@gregkh>
References: <20241218212707.zjli7be5qtamdfkx@jpoimboe>
 <20241219055157.2754232-1-ccc194101@163.com>
 <20241219225859.fw6qugbyoagrx63a@jpoimboe>
 <20241219225937.7jjii4kg4hc3d5rm@jpoimboe>
 <202412200927046763162@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412200927046763162@163.com>

On Fri, Dec 20, 2024 at 09:27:06AM +0800, ccc194101@163.com wrote:
> >Also, if it's for upstream, please cc lkml.
> 
> 
> May I ask what is LKML's email address

Please use the tool, scripts/get_maintainer.pl which will show you how
to do this.  Also, there is a great "how to write a first kernel patch"
tutorial at kernelnewbies.org that you probably should go through first
as well.

good luck!

greg k-h

