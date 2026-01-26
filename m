Return-Path: <stable+bounces-211691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGAzJRDld2k9mQEAu9opvQ
	(envelope-from <stable+bounces-211691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 23:05:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A728DD0A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 23:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3919B3033ABF
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC193016E0;
	Mon, 26 Jan 2026 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeB0gI+/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BE2FDC30
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465085; cv=pass; b=hplebIjYvaU2WWWMgzGU55pUVPiPlqinxvUrmBO0UYZ2Ruaah3KveUArs1ouwIRp9Ve41kQzUO6p7Jo+pqNIW6IHtjlOvn8VI0KNnwYK5bgEXd6PZ92LeCKwr8nX2Wc4a6+xRUWE6oDVQJA9gH/zXn8R7fkArxL4qMwAP38X5h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465085; c=relaxed/simple;
	bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M37ydwAEbrZx0277v6NBrjUj/kBYgk7qAE1pHBnK4tm+AIKBsnMlZGYNMOxn2iaEpV1XlelrQG4U+zHlBhwf3LJ+DKgdQyNlYVaCkBEZrN2tN557IP1k+PtLMYBI56g6C8dKiWAXNEtG9EVsgollEE6+5hGqdyANSjJyYhxP5aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeB0gI+/; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-790b7b3e594so51648797b3.3
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:04:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465083; cv=none;
        d=google.com; s=arc-20240605;
        b=NWGbxGiCmq4SHgMC4Qvkq8PVKBy9ZMmKLxU9mfpygmnSTzgE4TZR9s1HIjvSQ9NauF
         wAKoBvbOmtMCy7yddG9oPyvec1eQdVI7z6OaevBMbF9cFOtyI9zb18R267NSv9nIwVb3
         VPMengg46FSiX/pFEfNdBFCVjW+gI6Unt1WCxGmrG/sfA4QAswyj0v+HHCdylCRsE96K
         GdD+2JLzeA7MWZnJa3Aidgtp2o2hKPRhCJOunp2ERgFl3a1qjIwtY6EzeksBbKgJg75t
         01BhAtx8xyN5DQfIpKWZ+jir9sZ3M9+N9urm+tMUr2uEbgISkkVrucHN0eVpbLyJIvGd
         43vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        fh=HoXJiiBRyvprkcAB41nyiUxvx9GZjl7QvhJq+JnDKjE=;
        b=MaG32QUOHj+iKBUO/JvmSK6YyKkvES6U7FabDZ/2qVPSVDWgCWXOLBJyWzLq6IpaUl
         Hu64+IHQdRn3UeC+5BtazEAVETDhE0dxDFi7dWwXZcSxBj6da12xTT3nCXri7wJlg3rw
         Xz3EmREWMXAyB86HZDUb6IaC7W02SuI8n6ay6t4zEcfgBPWpFDkJJzcVNOT+VP9MAQcw
         6/+B52nvT76IXsgGEn+MyLJl6Hu1UZcdMCRZxfEP1/r71KVt6K0iEllOBr+/8LYunlbX
         EfnZAkl7j6Nz5nRirgxzxWTh1WB6DoRItaIIsPfXvXG+yodbBREmUnjJ9olqsEhY4b8g
         a2lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769465083; x=1770069883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        b=SeB0gI+/2Wx2lV50hnRI/YgaHZvHsKB28MOlNnzpAI5vdgs7gZiN4AB425/Hhclvjz
         bLhN3ZNejxhIoqyKoVyviDlSJkhUF+379Ghqa0cmYteBzLqorjm8Zw+JZREQGziTH58P
         WmKXqRte247yz/AFC3xrDqN70GtoTNspJXrpHCkvw11dkRPusn47aQOkiIBApUDTAAjZ
         hgzkqsZl0MRTh/jWLLLytrleb4wtwlidiJMi4HecXnS32JShIY8mGKaCC+zBPTutZi0i
         oUW3CLr5O0QzInsOQPjf5U1HZeVvJX9fmmkCqwr2978ua0z4Zj1Qn3U9FbXH/U9nYIzD
         rZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465083; x=1770069883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YG21uS5Q3aTxJoxgOLQVMsuQQQPt4JTzGp95ovsFsE=;
        b=asBaOB3Pg638Oeh2Lwc+EfPzkMte4D7BOw2j+VKpCzJRd/BdMP2hEy0Y5uxqpBn9X+
         cg4Svcav0TdwMpEfwdPo76QI750dzGMyRItd4a3OTzSQCa7KxjCxHTd4FNJaPeHtY1zf
         KOusqPcrIvlHWnk+GtVnUVpVNcP2HWbeSSa9iJY8osBc4gEb8oYtMr4mfIqyarLZmMIe
         UXfHkJw4xFi+d1djQOIJwBC7yGNx2xGUS27Q7CpQM4BsfOx6A1Wyl90sgaTcpzo8tqLY
         ITJNN3pE6O03CdYWZWydXjUCwH/xFeSTDDw6rUOEYiCF1jbsDZOAacPu+ERnEOZxJFM9
         r6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeKv2NdlGYJZ8BsHkFgyYjSExOi/UuORfgXSwKINx2SNdK+OqWqCZ7Lrt4Ggim39GVD2bFKB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplF/zk2n6cDi0jO1iUYuJsY7nfDJ3pqrGW55l3C00NI/fcjy8
	VCkYu77EdHKWXFfjNPuywLGQsW22ZuKMFrp3i55JGebOIHeAMNebpOGWo6+ptscKH9/tv8ff64l
	VtMbeBkGgEmB63/zwLXkzCq/5xrx0Lv4=
X-Gm-Gg: AZuq6aLrTFZH2JkV0IvO6qVKjYqG6sNAFKe4Fizu6uVaw7E9EBlccF27W5HYmkIPmgS
	9WgxNPhwc/zD1W0ZaGaVjABDdUcnrjkX/vAjHAYWP3UmAie1MCGv4Z83H1yohn8ONgH0mwLNXcW
	lOSAkQpqjR/clPXrrSicNit2zCDdoHWGm+tj3gND44xNzyZZjwoGLQwSCUKDHsCJSil0a9RnjNq
	9n71h2a9p7sWDLZLzHGty9ab/NHKzy4Ud8t5KO45jAJ0P4zwh7Zd88PcXFivQYYwF8CB4bNkG9F
	7SWwd9JaMSsEzZyNMJcHjRYWwxyv
X-Received: by 2002:a05:690c:e3eb:b0:794:2c3d:7952 with SMTP id
 00721157ae682-7945a845df7mr47379077b3.3.1769465082722; Mon, 26 Jan 2026
 14:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aXcovK8uhsiaHumT@debian.local> <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A907097A88AEB32669C1E5A393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Mon, 26 Jan 2026 22:04:31 +0000
X-Gm-Features: AZwV_QiceH7qsXObZwUw3W1_GqQzTM8Z2nnHyRpegpE1rqs3Px19JUyms_T0uKk
Message-ID: <CAP-bSRZ60CSEtR-_9OL6k_Lzg=w8MtD2i79KpwF+nYYzgak=-Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>, "Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, "gustavoars@kernel.org" <gustavoars@kernel.org>, 
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211691-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid,sipsolutions.net:email]
X-Rspamd-Queue-Id: E4A728DD0A
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 13:45, Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Chris Bainbridge <chris.bainbridge@gmail.com>
> > Sent: Monday, January 26, 2026 10:42 AM
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> > Cc: kvalo@kernel.org; Berg, Johannes <johannes.berg@intel.com>;
> > benjamin@sipsolutions.net; gustavoars@kernel.org; linux-intel-wifi@intel.com;
> > linux-wireless@vger.kernel.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
> >
> > On Mon, Jan 26, 2026 at 07:15:54AM +0000, Korenblit, Miriam Rachel wrote:
> > >
> > > Hi Chris, could you please provide the full log?
> > >
> > > Miri
> >
> > Sure, for 6.18.0 see https://lore.kernel.org/linux-
> > wireless/aTDoDiD55qlUZ0pn@debian.local/
> >
> >
> Thanks!
>
> could you please test if the attached patch eliminates the panic?

Yes, that seems to work fine.

Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

