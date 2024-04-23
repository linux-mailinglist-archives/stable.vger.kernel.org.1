Return-Path: <stable+bounces-40747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664B08AF62E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C07B275C1
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D3F13E3FE;
	Tue, 23 Apr 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="aqTTKTlf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8v3EwNG"
X-Original-To: stable@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA1B13E3FF
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895262; cv=none; b=H+4UPGGsiaPQTio29nFdW/GNn0VtNmrAagzVa0ECm1fVNzqup+qP+kuYwRCv9YubGh5sHKyGh3UjvZDeW4ETAfE47Nw98cNPbxCrj7zm0ne2ojwR/Ya56NohdVZNIUEYur8SIz3WXE6LvRa7L1QUeGWg49lVW7fU5J/Ga4Yw2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895262; c=relaxed/simple;
	bh=Kp5yJkJtlu/K5IssAYlDdc/uTxh0v0hIYarONYlVNgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNLefi1PzHn1F2DILrDcfl9Gn1kpLiGoO3/2dDNowY3MtNPA9S5hoFJ5KYAWgvCFnybkP0lRYWw1T8XJlCIVEyLc4ZBla526R3BTLu1mDZAFP4nCPAWySRwLs5wQgWg/FOKgha9g4q1MhZxtdb7vZ51G982iiTuEY7MAwJPhUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=aqTTKTlf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8v3EwNG; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 9A3D82CC01DF;
	Tue, 23 Apr 2024 14:00:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 23 Apr 2024 14:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713895257; x=1713902457; bh=t4D22upmav
	Q3+4AtkRtUngE0hPyofqmE6WNUCf03+40=; b=aqTTKTlfqKT16v9g1oW4YjAkXZ
	POS3K4MqabeQ4THgFuetpcTz597OOCztysZKFnkSsvHOtPPnnUPZzvrJGNxiWLW5
	BajEJCE/kfmdUxo/gSxcBUWZN5fMrLsOKVraLPSzYmwbUy1FgpnbvjINTaqwWtEu
	J1Yz7g/iMrUWwPbu2/N2bi0K2aAXB6m4JyqzPJ0AeyP6UKLiZdN2IYirwR99I6sJ
	A0ba0GKN1P6G4Ec4c7pWjaGoDoLoEpDkREJqDwNpJ5tyavHzak799n6bVtcfvSBQ
	wjEp9Yhz6fWgc37sAvomJPEiEmoHaKQ9cQS+Cemlkfw0yqWe+ienUSj0C2Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713895257; x=1713902457; bh=t4D22upmavQ3+4AtkRtUngE0hPyo
	fqmE6WNUCf03+40=; b=B8v3EwNGo0wQw8ed6MXVlMivanogbZsdLRat6cRH2Fh/
	qhegxgknwkh7Ky1ptnY159god/CLSEoGQYNOGCU7Pq+e6feoGsOwlmv8asysm/bH
	VB1ZOLkfhCseDNsYB4Rvb3OeZzwRCSxgR/rhmQK7vpIjj+FY3s5TYMk45Z9yFpXZ
	5dNZ0ukRj3PK8jZMeEkfLpkYfD/3KjggNx3jxAdkToiHAVNPDcZDPqXH3d8bZbuz
	MfyxKU098xm6T3vrL3S7NcVhhT6u8Dv/eo/VpZxMek2bEs1Rs8YhQ0rx6aIDmcfH
	4Zjz0Qs4TrDS0OdXHbWrxMl1XKx6bBRktl8w3wdJqQ==
X-ME-Sender: <xms:WPcnZvtpaD-owBCDjwxiCwE14MGvGfOfF-lGiXL4p9yN2tANUaAwIw>
    <xme:WPcnZge-BnQL68D2FDmDLj0ZAGBDfSvEcRA7JF147FzLT3_mFMgypxsA1eY15LiNr
    AZn-nfXJ_f5ag>
X-ME-Received: <xmr:WPcnZiyLba1SzfIF7ezAXuHW8B-2EgWzpsiRVEf4nPE9VD8e3N2mJLasLFBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:WPcnZuM1IfyjcSme3SV3sdTX-M_hUjWK2E0Y_uoG60IdHjTwMEGp9g>
    <xmx:WPcnZv-nFfTR_mpweF9T7UELEaFW9xr3OXB4gz7_UAAbmFsazlhdmw>
    <xmx:WPcnZuU9IuS9EuO5ojWenEaejqL2Aw_gyVnyL6Da8hOAL6l9yngKCA>
    <xmx:WPcnZgeq6f3zJYjmci1XrNvamrPwjX0PNoXJ72ZyZfZQtwYM8zrqTw>
    <xmx:WfcnZugcx6uDxbA5T4CtMi-WSV7hF0lpc7HFAWQNN2cZQqr82FB223HQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 14:00:56 -0400 (EDT)
Date: Tue, 23 Apr 2024 11:00:46 -0700
From: Greg KH <greg@kroah.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: stable@vger.kernel.org, surenb@google.com,
	David Hildenbrand <david@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Nicolas Geoffray <ngeoffray@google.com>,
	Peter Xu <peterx@redhat.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.8.y] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
Message-ID: <2024042339-jumble-graceless-b141@gregkh>
References: <2024042334-agenda-nutlike-cb77@gregkh>
 <20240423175238.1258250-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423175238.1258250-1-lokeshgidra@google.com>

On Tue, Apr 23, 2024 at 10:52:38AM -0700, Lokesh Gidra wrote:
> Commit d7a08838ab74 ("mm: userfaultfd: fix unexpected change to src_folio
> when UFFDIO_MOVE fails") moved the src_folio->{mapping, index} changing to
> after clearing the page-table and ensuring that it's not pinned.  This
> avoids failure of swapout+migration and possibly memory corruption.
> 
> However, the commit missed fixing it in the huge-page case.
> 
> Link: https://lkml.kernel.org/r/20240404171726.2302435-1-lokeshgidra@google.com
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> Cc: Nicolas Geoffray <ngeoffray@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit c0205eaf3af9f5db14d4b5ee4abacf4a583c3c50)
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

Now queued up, thanks.

greg k-h

