Return-Path: <stable+bounces-223078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHMYAxNAqGl6rQAAu9opvQ
	(envelope-from <stable+bounces-223078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 15:22:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3020141F
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 15:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF25F303432A
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C75478D;
	Wed,  4 Mar 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AVxUdcqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134E11427A;
	Wed,  4 Mar 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634125; cv=none; b=qe6aEAsL/uFdNAgQcJsNr2ONLHZfADOOxhHG8dTLeOajqOBO26Z9Fg6W0mkWq8xyFKNWjFtccqftEYW4bfIbhCqZF1dCg9FgUVV7CfOU6y4cBhQKdK9J6f15pqKhNTcS7/olCb7ky0ltVw46FR0WZc3OyEbzBpwXowoUC8sRzkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634125; c=relaxed/simple;
	bh=gi3+FbsRPI9ghJPSxXbDFsBbtR2ztSR/cQb0ghDSIMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HebCGtuNNXYfxmBmy03jRqIHpbXRcdhNkFHeWoHx34sIsgrgIoq0C+eM+OQBghIyzPIRunt36wQrdg5wC2mdiq/O5Zay7DsJ2QtisIbkvzH7VhRAyYrgAG71wQ2HscU1N7ebxonQv2DfY8asYAU028ga+FdgFb1Ij3cBR4Q/Yn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AVxUdcqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ABEC4CEF7;
	Wed,  4 Mar 2026 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772634124;
	bh=gi3+FbsRPI9ghJPSxXbDFsBbtR2ztSR/cQb0ghDSIMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVxUdcqNNCT2O64/enNyBiKR+x8GCi7/EPWld5n56MR3P2g/5FiSRC8dqvoYDZy6i
	 njp43tsNBgmhLjETvb3D7OgYXYLNSCDQ4NZ8b+8/+a9KlIM9i1Ka4OHCxuqGBGKLlF
	 UuA6divOHuFe4tFmhpD9JhfDgOYOvEV4e4XcD058=
Date: Wed, 4 Mar 2026 15:21:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bharath SM <bharathsm.hsk@gmail.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, dhowells@redhat.com,
	sprasad@microsoft.com, pc@manguebit.com, ematsumiya@suse.de,
	henrique.carvalho@suse.com, bharathsm@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] smb: client: fix page cache corruption from
 in-place encryption in SMB2_write
Message-ID: <2026030442-cleft-appealing-93ec@gregkh>
References: <20260304140452.1606662-1-bharathsm@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304140452.1606662-1-bharathsm@microsoft.com>
X-Rspamd-Queue-Id: 7AD3020141F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223078-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,microsoft.com,manguebit.com,suse.de,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:34:52PM +0530, Bharath SM wrote:
> SMB2_write() passes data kvecs inline in rq_iov by setting
> rqst.rq_nvec = n_vec + 1. When SMB3 encryption is negotiated,
> smb3_init_transform_rq() -> crypt_message() encrypts data in the
> kvec buffers in-place.
> 
> For synchronous writes through cifs_write(), the kvec buffers point
> directly into the page cache via kmap(). In-place encryption overwrites
> the page cache with ciphertext. If the send fails with a replayable
> error such as -EAGAIN (e.g., from a connection reset), SMB2_write()
> retries the write using the same iov[1] buffer. Since iov[1] now
> contains ciphertext from the first attempt, the retry encrypts and
> sends ciphertext-as-data to the server, resulting in data corruption.
> 
> The corruption is most likely to be observed when connections are
> unstable, as reconnects trigger write retries that re-send the
> already-encrypted page cache data.
> 
> The sync path can be reached during partial-page O_WRONLY writes when
> the page is not in cache (common for append workloads with repeated
> open/write/close patterns).
> 
> The async write path (smb2_async_writev) is not affected because it
> passes data via rqst.rq_iter, which the encryption layer handles
> without modifying the source buffers.
> 
> Fix by setting rq_nvec = 1 (header only) and moving data kvecs into
> rq_iter via iov_iter_kvec().
> 
> Signed-off-by: Bharath SM <bharathsm@microsoft.com>
> Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/smb2pdu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index a8890ae21714..a88a19dec494 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -5072,7 +5072,11 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
>  
>  	memset(&rqst, 0, sizeof(struct smb_rqst));
>  	rqst.rq_iov = iov;
> -	rqst.rq_nvec = n_vec + 1;
> +	rqst.rq_nvec = 1;
> +	iov_iter_kvec(&rqst.rq_iter, ITER_SOURCE, &iov[1], n_vec,
> +		      io_parms->length);
> +	rqst.rq_iter_size = io_parms->length;
> +
>  
>  	if (retries)
>  		smb2_set_replay(server, &rqst);
> -- 
> 2.45.4
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

