Return-Path: <stable+bounces-227886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOG2FhrbwGn6NQQAu9opvQ
	(envelope-from <stable+bounces-227886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:18:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A662ECF22
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 550CC3006959
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 06:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DF12D5C8E;
	Mon, 23 Mar 2026 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LhZKeoUB"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02E2C159E;
	Mon, 23 Mar 2026 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246469; cv=none; b=jpaJqaQWzCacbUZ2D6b4h5rC5QK54prXueOohl4mWudp4LwTWk0xn7BEuehAAUnfAOGgroZ50gjz0+ZOSnzAX/cdWWqLqAZV80wbGVeYBD+qHJfunlf0TY6xv+09m43FW0War3EY9c/edqWOH1JoDe18bDzeprwspjRkyE5amto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246469; c=relaxed/simple;
	bh=GCIqsLPVr+61QNd37nhrm/ST/VFIow857wDrffSpNDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aefaq12RnU/VF+pSBJGM1oiJQn8rhD3srjVPK+cXnUHUVtwDXLhRRQVM/Fr5Z4IChgm3Ubpzu5zKzCV6spj6fjmkD9p6kRmDAPWK9N5FMwV1fsDF3MauO+lFYwtwPFK9Q9UzAj1Ch+H4qfTkNXFVMgrdi1xRjYl0SdpIODwQARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LhZKeoUB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5JRUWD9+glQoElJ5wXXwk9ntDQi0KqbL7DUv65g9YE4=; b=LhZKeoUBBx2ZpCMVtF+qZbjmyJ
	QsD9xnPYpc3M5oQwUQPo1oKFaqjxVUDOXuMJoja1k2ram1gNPWZuYNJ9Di/fsC3nSHlt3PqyNP/dg
	xZkA+w0hrOr/EdnaoWAJEm0ZD2Cs020CTHyukYrPHEYJgxAfgjOI1JvkzZwgPk6b2F7Wh8Ddbfgaj
	v98Wi1TckfmtuwsFfeFb01DOnHCaNOBtEIsVp1YPbEK0qvWJKYiixCE59JfVg0QRRUHtFpYmaQpL2
	khZPbkU17qoSvglGM8sSRq9O+WrKMbO+ojwD7a/QOrvaz2WnBPrWPHjN8XZR3//NE8cHYJYjjxZgn
	fWVGPXuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4YYV-0000000G76O-1lWu;
	Mon, 23 Mar 2026 06:14:27 +0000
Date: Sun, 22 Mar 2026 23:14:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] xfs: annotate data race on li_lsn in CIL formatting vs
 AIL insertion
Message-ID: <acDaQ6DQ7ehMji4r@infradead.org>
References: <20260320025507.3331221-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320025507.3331221-1-zzzccc427@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227886-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0A662ECF22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:55:07AM +0800, Cen Zhang wrote:
> Under simple interleaving on 64-bit architectures this is benign since
> li_lsn monotonically increases and both old/new values are valid
> checkpoint LSNs.  However, on 32-bit architectures the 64-bit xfs_lsn_t
> can be torn into two 32-bit loads, producing a bogus LSN that could
> cause log recovery to make incorrect replay decisions.  XFS already
> acknowledges this concern via the xfs_trans_ail_copy_lsn() helper which
> takes ail_lock on 32-bit.

Yes.

> Annotate with READ_ONCE()/WRITE_ONCE() to prevent compiler-level
> tearing on all architectures.

Well, xfs_trans_ail_copy_lsn pretty clearly documents that we actually
need a locak for the 32-bit case.  Assuming we don't have lock ordering
issues, using xfs_trans_ail_copy_lsn would be the right thing here.

> -	xfs_inode_to_log_dinode(ip, dic, ip->i_itemp->ili_item.li_lsn);
> +	xfs_inode_to_log_dinode(ip, dic, READ_ONCE(ip->i_itemp->ili_item.li_lsn));

.. and either way please avoid the overly long lines.


