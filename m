Return-Path: <stable+bounces-226019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC8yKo5auWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:43:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 120522AB21E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B0DD30B701A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBAA2BCF5D;
	Tue, 17 Mar 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H2NuFAr0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7C2C1595
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754854; cv=none; b=tMlArpiXRU2PSDBbxdbGTgjvjYr2D4osibvT2Ccyi8eDlXpgcTfKPfeAmr50PErNOfcuFct58yQl16HsIJkcRxGvE++AOnE8QQZsli7Z08EGjPUpvUwZsQe40XvYp+hNxXvx1IahfYJCsfPrxQf3oQQ9oar72jzJ0XdSFFEGF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754854; c=relaxed/simple;
	bh=NlqjEjxHyvGIuPxHZj6i+9LpMdiPyI6UTfTO9+ZR4KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvrosXjSkvl0mBz9665L2MWeWL9+U/oAXAkVJQ9A75DaE917QpzFnM9oyQbnqOrrmpCgrBC7/mI4zloaO9RLQdhFVWIfUDawIcMxbgdMmbgKSvS6NBwsR0QQDvG7MsviURdQlupc1lFP018AtvjdF96q2JM2RU0qF/W4XZ+OMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H2NuFAr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29554C4CEF7;
	Tue, 17 Mar 2026 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773754854;
	bh=NlqjEjxHyvGIuPxHZj6i+9LpMdiPyI6UTfTO9+ZR4KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2NuFAr0NWIzZqFogJiNLJLsmgZOzlLrRiQOdLpcDQj8i9tUFnHrwvPJnxEWDf7Qd
	 h0dtyFLuT4DWC8OSDx61qJcnxegxIuQlkJRGeQ9k3mASG89h9v8DGF1+BY4wJyWQnn
	 l+zkeY92li871rp5o1mF5XM4AWJSY3Dpdpf5TMwo=
Date: Tue, 17 Mar 2026 14:34:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Werner Kasselman <werner@verivus.ai>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ksmbd: fix use-after-free and NULL deref in
 smb_grant_oplock()
Message-ID: <2026031747-tiptoeing-fifty-9cc8@gregkh>
References: <20260317130554.2609496-1-werner@verivus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317130554.2609496-1-werner@verivus.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-226019-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,verivus.com:email]
X-Rspamd-Queue-Id: 120522AB21E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 01:05:56PM +0000, Werner Kasselman wrote:
> smb_grant_oplock() has two issues in the oplock publication sequence:
> 
> 1) opinfo is linked into ci->m_op_list (via opinfo_add) before
>    add_lease_global_list() is called.  If add_lease_global_list()
>    fails (kmalloc returns NULL), the error path frees the opinfo
>    via __free_opinfo() while it is still linked in ci->m_op_list.
>    Concurrent m_op_list readers (opinfo_get_list, or direct iteration
>    in smb_break_all_levII_oplock) dereference the freed node.
> 
> 2) opinfo->o_fp is assigned after add_lease_global_list() publishes
>    the opinfo on the global lease list.  A concurrent
>    find_same_lease_key() can walk the lease list and dereference
>    opinfo->o_fp->f_ci while o_fp is still NULL.
> 
> Fix by restructuring the publication sequence to eliminate post-publish
> failure:
> 
> - Set opinfo->o_fp before any list publication (fixes NULL deref).
> - Preallocate lease_table via alloc_lease_table() before opinfo_add()
>   so add_lease_global_list() becomes infallible after publication.
> - Keep the original m_op_list publication order (opinfo_add before
>   lease list) so concurrent opens via same_client_has_lease() and
>   opinfo_get_list() still see the in-flight grant.
> - Use opinfo_put() instead of __free_opinfo() on err_out so that
>   the RCU-deferred free path is used.
> 
> This also requires splitting add_lease_global_list() to take a
> preallocated lease_table and changing its return type from int to void,
> since it can no longer fail.
> 
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Fixes: 1dfd062caa16 ("ksmbd: fix use-after-free by using call_rcu() for oplock_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  fs/smb/server/oplock.c | 72 ++++++++++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
> index 393a4ae47cc1..9b2bb8764a80 100644
> --- a/fs/smb/server/oplock.c
> +++ b/fs/smb/server/oplock.c
> @@ -82,11 +82,19 @@ static void lease_del_list(struct oplock_info *opinfo)
>  	spin_unlock(&lb->lb_lock);
>  }
>  
> -static void lb_add(struct lease_table *lb)
> +static struct lease_table *alloc_lease_table(struct oplock_info *opinfo)
>  {
> -	write_lock(&lease_list_lock);
> -	list_add(&lb->l_entry, &lease_table_list);
> -	write_unlock(&lease_list_lock);
> +	struct lease_table *lb;
> +
> +	lb = kmalloc_obj(struct lease_table, KSMBD_DEFAULT_GFP);
> +	if (!lb)
> +		return NULL;
> +
> +	memcpy(lb->client_guid, opinfo->conn->ClientGUID,
> +	       SMB2_CLIENT_GUID_SIZE);
> +	INIT_LIST_HEAD(&lb->lease_list);
> +	spin_lock_init(&lb->lb_lock);
> +	return lb;
>  }
>  
>  static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
> @@ -1042,34 +1050,27 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
>  	lease2->version = lease1->version;
>  }
>  
> -static int add_lease_global_list(struct oplock_info *opinfo)
> +static void add_lease_global_list(struct oplock_info *opinfo,
> +				  struct lease_table *new_lb)
>  {
>  	struct lease_table *lb;
>  
> -	read_lock(&lease_list_lock);
> +	write_lock(&lease_list_lock);
>  	list_for_each_entry(lb, &lease_table_list, l_entry) {
>  		if (!memcmp(lb->client_guid, opinfo->conn->ClientGUID,
>  			    SMB2_CLIENT_GUID_SIZE)) {
>  			opinfo->o_lease->l_lb = lb;
>  			lease_add_list(opinfo);
> -			read_unlock(&lease_list_lock);
> -			return 0;
> +			write_unlock(&lease_list_lock);
> +			kfree(new_lb);
> +			return;
>  		}
>  	}
> -	read_unlock(&lease_list_lock);
>  
> -	lb = kmalloc_obj(struct lease_table, KSMBD_DEFAULT_GFP);
> -	if (!lb)
> -		return -ENOMEM;
> -
> -	memcpy(lb->client_guid, opinfo->conn->ClientGUID,
> -	       SMB2_CLIENT_GUID_SIZE);
> -	INIT_LIST_HEAD(&lb->lease_list);
> -	spin_lock_init(&lb->lb_lock);
> -	opinfo->o_lease->l_lb = lb;
> +	opinfo->o_lease->l_lb = new_lb;
>  	lease_add_list(opinfo);
> -	lb_add(lb);
> -	return 0;
> +	list_add(&new_lb->l_entry, &lease_table_list);
> +	write_unlock(&lease_list_lock);
>  }
>  
>  static void set_oplock_level(struct oplock_info *opinfo, int level,
> @@ -1189,6 +1190,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
>  	int err = 0;
>  	struct oplock_info *opinfo = NULL, *prev_opinfo = NULL;
>  	struct ksmbd_inode *ci = fp->f_ci;
> +	struct lease_table *new_lb = NULL;
>  	bool prev_op_has_lease;
>  	__le32 prev_op_state = 0;
>  
> @@ -1291,21 +1293,37 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
>  	set_oplock_level(opinfo, req_op_level, lctx);
>  
>  out:
> -	opinfo_count_inc(fp);
> -	opinfo_add(opinfo, fp);
> -
> +	/*
> +	 * Set o_fp before any publication so that concurrent readers
> +	 * (e.g. find_same_lease_key() on the lease list) that
> +	 * dereference opinfo->o_fp don't hit a NULL pointer.
> +	 *
> +	 * Keep the original publication order so concurrent opens can
> +	 * still observe the in-flight grant via ci->m_op_list, but make
> +	 * everything after opinfo_add() no-fail by preallocating any new
> +	 * lease_table first.
> +	 */
> +	opinfo->o_fp = fp;
>  	if (opinfo->is_lease) {
> -		err = add_lease_global_list(opinfo);
> -		if (err)
> +		new_lb = alloc_lease_table(opinfo);
> +		if (!new_lb) {
> +			err = -ENOMEM;
>  			goto err_out;
> +		}
>  	}
>  
> +	opinfo_count_inc(fp);
> +	opinfo_add(opinfo, fp);
> +
> +	if (opinfo->is_lease)
> +		add_lease_global_list(opinfo, new_lb);
> +
>  	rcu_assign_pointer(fp->f_opinfo, opinfo);
> -	opinfo->o_fp = fp;
>  
>  	return 0;
>  err_out:
> -	__free_opinfo(opinfo);
> +	kfree(new_lb);
> +	opinfo_put(opinfo);
>  	return err;
>  }
>  
> -- 
> 2.43.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

