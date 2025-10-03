Return-Path: <stable+bounces-183243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 994B1BB76E5
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84DB64E454C
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BD29C35A;
	Fri,  3 Oct 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Xvdg8Y9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cpZY+MJ/"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDD292B4B;
	Fri,  3 Oct 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507262; cv=none; b=bGfVsWY7/WAWLS1Z16a20aM5/GGAiRR+lgIK5tfyPZDuWJbrlA0WoTB33Bg/sIi2yLwR4fS69vVRMH95bkf++TEUJRArPQucJDMJ1I4iKI7Va2irARMJNq92fZyVt4X7GoqQOIzsYxV/JdCxnlOsVJkORp3V7brI3vqu4IW+63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507262; c=relaxed/simple;
	bh=cdlQo7Y0j4hHgbuw4Af+XboBL8Bb06NJHd8C8Lwhbnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHU1wL6beOh2oT5fQo121Mv8rD46OEf6SpvNUegK1NyYQuSpWv+7rl8tjWv5WjGpUTF5ceWbCRZZwJQsoc//YqZrXIyNz1TV4tPgM7l6rzYFfXssXNuc2RnbVx231g8HT6Z/9eXidAZ5QtdhoVVsvWuc0q9Gv044Uv0mBpe8uh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Xvdg8Y9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cpZY+MJ/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93F7514001D6;
	Fri,  3 Oct 2025 12:00:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 03 Oct 2025 12:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1759507259; x=
	1759593659; bh=nV/TvSgZMitb0mxDDmCIB9D+mWhQJM8naIFJGNjXnfw=; b=X
	vdg8Y9wrz7KOgx02N4V6QTvP+I88EWKv4coweQ50qVLJ9L+plpwIbw8onRT2eqFC
	iUGBbOnmRxfEfWibOq8YsFiFMZuXeHIofOGo2V9DAWhjDbEqUOlcyw3sCx4kM2rU
	lA9PHa5z81ukytEI0Lg1g41W7K/kx8U+7ETKuQX0PJ00eE5fAI6xCMfiddYiGdHk
	+alcc7UoHhAn9DdJyM3ykEY15qDbY85E437XhTB//W6pypnas2IW4ch7KdYcY/T7
	s7BtlQS73sc3AtU3RjlfhBozqVuRvf7tVc4Jg1Wv9zEa4M5+svaqZa5o9Q+k8H2U
	MOGybciyN/5w+aXmgxl7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759507259; x=1759593659; bh=nV/TvSgZMitb0mxDDmCIB9D+mWhQJM8naIF
	JGNjXnfw=; b=cpZY+MJ/jqAETe+7MKtZonnmhDfkmDbsw8N1aPNW3IMixUGRWfy
	Hf/N/9csiWZd6qNIok6pl05og0nWNWxoQmjWNMtnrumIfoa9iem/bJjbI/+99JsC
	JQfOaTXetu0Vsi15UKU0Kc55V5yKClOdLn5sWo8yHUtSmEvIUpmaQRCtYNm2V8ri
	9HudK9zrk8LBf3/tLlK93FOcb3T5VUBFOztnxUvW3q/+HINjkThrsSWpBid83N1r
	za7Fin4+xlvZb2ZURQAfMu8xmlcuV1pPIQwTrkjZ8vJMvaaOXEfV1QemOwuCgbCx
	nXobwVcDhZ5RMla2foxPKodK15JBbRHOCIQ==
X-ME-Sender: <xms:O_PfaHX5obhnsrVyh5zGRyKziZf6R1h3KfQ_kLEWhTy5V9ST8iJURA>
    <xme:O_PfaPfT1LECRTAR0AgIB5_N9-WkyfAM5WKHC6umyDkzOTpIAxiCqYZkWAAFr_8WH
    TZyUhLrQh4ldU_faJ3jtQPwNIXqPFG10Xl2v6MT45XSgWpVS44klO4>
X-ME-Received: <xmr:O_PfaAsxmt6SvE80d8tDx_-gUh8kbMAUBVEggXVGRi_ZKml-AAvot6hE-JJ_Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeegfeehleevvdetffeluefftdffledvgfetheegieevtefgfefhieej
    heevkeeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtoheprghk
    phhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvih
    gusehrvgguhhgrthdrtghomhdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghs
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthht
    oheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepmhhhohgtkhhosehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:O_PfaOh6i_eJnqpEN2Pf58TsNXEndkcU0QUQPe--q1jQo3Pc0bPcLw>
    <xmx:O_PfaOuZN2vNAsKA6420COVGK4wPZMQrCDoy2qLSN1gj1lN0pRKJPg>
    <xmx:O_PfaA7xc5zTB2CxT2zYMHWsKveYRVpoB99tY8lS9yitiGEFPS1fhw>
    <xmx:O_PfaJvyKEOo5zL5QHLKcH1E_Xv5GxHqgpQ3iEiTyvmbKa92zKkqRA>
    <xmx:O_PfaK9E3wnW4fmuttGGRZ4Ve7qL45DgMnv1YghJW1P1XgS9K9bitr1V>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 12:00:58 -0400 (EDT)
Date: Fri, 3 Oct 2025 17:00:56 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
Message-ID: <nf7khbu44jzcmyx7wz3ala6ukc2iimf4vej7ffgnezpiosvxal@celav5yumfgw>
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003155238.2147410-1-ryan.roberts@arm.com>

On Fri, Oct 03, 2025 at 04:52:36PM +0100, Ryan Roberts wrote:
> fsnotify_mmap_perm() requires a byte offset for the file about to be
> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page offset.
> Previously the conversion was done incorrectly so let's fix it, being
> careful not to overflow on 32-bit platforms.
> 
> Discovered during code review.

Heh. Just submitted fix for the same issue:

https://lore.kernel.org/all/20251003155804.1571242-1-kirill@shutemov.name/T/#u

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

