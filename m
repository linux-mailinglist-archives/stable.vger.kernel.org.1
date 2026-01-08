Return-Path: <stable+bounces-206342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7826CD03CC1
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49E4A305956E
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA9C4F7963;
	Thu,  8 Jan 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz320DjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA24F7970
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875762; cv=none; b=tey4OF5EQcisaO+CVyhsP8otTVVaWS4RrsGl7EJYaT8AdEToTtvoGMGg69K0oC/PWKJlTijnjtB1JEUB5XCxGmDW+2VuWt4UKZPiy895U3HeYyPfjfBsHwZkpSAELFYTvgZNYy3oXYJfTiixkwGEo5iP9fqyreOiHFWbCL+If+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875762; c=relaxed/simple;
	bh=JK7iqYFpZOazqtvI0P2E2dE/cL5URogZyWyOXyoPync=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5sZ91qI+9TBGRC1C3POSgc7yLvrG+cUNmgJ9+hnYQY6MzdrssVr3DclceUL/5GdSRB76XeAUyJ8vHGzyGsBxWUEuo22EkFso3rpmi/hcJYupk/tZl2Lqh+MSNjT0L6Uid5e6sTtRM6W4rZs0OyGUSr6Q+febYSxXv4H8JZebFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz320DjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9DDC19421;
	Thu,  8 Jan 2026 12:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767875762;
	bh=JK7iqYFpZOazqtvI0P2E2dE/cL5URogZyWyOXyoPync=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tz320DjUuxlIYpSQGUwzPBqHQs9Ekl3SCdm8S5FA9C2PI55HyVCw2yZAM6uY80kjr
	 IBu/shB2QDlgRZM0t0AFm5A7YeVQahVgoTvqptTGuZMW79gy6FTV4SxC4v3JmWpFY9
	 195DOhO2lLbGyMAlpR19a59rJBL5SVHIU8qPLoKL0KH/+x8/Tcv0oSdWQUtjt0aM44
	 ilN4NsOOWS9ixoYGdttD1oVX+cFeVqZ8rhNxwguQSWi2ecoKCcBLKcTEswsIqx0N1n
	 Wtj1mwYXiop84bIGJX5Cf3i0MRAaTMwb9eoPKUEKxMinNKSLpApVUGMw8a0syRQFo/
	 1xQxcdMtiwl6Q==
Date: Thu, 8 Jan 2026 14:35:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: gregkh@linuxfoundation.org
Cc: noodles@meta.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tpm2-sessions: Fix tpm2_read_public range
 checks" failed to apply to 6.12-stable tree
Message-ID: <aV-krVu6--uej-RR@kernel.org>
References: <2025122907-stream-lasso-ba6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025122907-stream-lasso-ba6e@gregkh>

On Mon, Dec 29, 2025 at 01:34:07PM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x bda1cbf73c6e241267c286427f2ed52b5735d872
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122907-stream-lasso-ba6e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From bda1cbf73c6e241267c286427f2ed52b5735d872 Mon Sep 17 00:00:00 2001
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Date: Mon, 1 Dec 2025 15:38:02 +0200
> Subject: [PATCH] tpm2-sessions: Fix tpm2_read_public range checks
> 
> tpm2_read_public() has some rudimentary range checks but the function does
> not ensure that the response buffer has enough bytes for the full TPMT_HA
> payload.
> 
> Re-implement the function with necessary checks and validation, and return
> name and name size for all handle types back to the caller.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan McDowell <noodles@meta.com>
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index be4a9c7f2e1a..34e3599f094f 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -11,8 +11,11 @@
>   * used by the kernel internally.
>   */
>  
> +#include "linux/dev_printk.h"
> +#include "linux/tpm.h"
>  #include "tpm.h"
>  #include <crypto/hash_info.h>
> +#include <linux/unaligned.h>
>  
>  static bool disable_pcr_integrity;
>  module_param(disable_pcr_integrity, bool, 0444);
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 385014dbca39..3f389e2f6f58 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -163,53 +163,61 @@ static int name_size(const u8 *name)
>  	}
>  }
>  
> -static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
> +static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
>  {
> -	struct tpm_header *head = (struct tpm_header *)buf->data;
> +	u32 mso = tpm2_handle_mso(handle);
>  	off_t offset = TPM_HEADER_SIZE;
> -	u32 tot_len = be32_to_cpu(head->length);
> -	int ret;
> -	u32 val;
> -
> -	/* we're starting after the header so adjust the length */
> -	tot_len -= TPM_HEADER_SIZE;
> -
> -	/* skip public */
> -	val = tpm_buf_read_u16(buf, &offset);
> -	if (val > tot_len)
> -		return -EINVAL;
> -	offset += val;
> -	/* name */
> -	val = tpm_buf_read_u16(buf, &offset);
> -	ret = name_size(&buf->data[offset]);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (val != ret)
> -		return -EINVAL;
> -
> -	memcpy(name, &buf->data[offset], val);
> -	/* forget the rest */
> -	return 0;
> -}
> -
> -static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
> -{
> +	int rc, name_size_alg;
>  	struct tpm_buf buf;
> -	int rc;
> +
> +	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
> +	    mso != TPM2_MSO_NVRAM) {
> +		memcpy(name, &handle, sizeof(u32));
> +		return sizeof(u32);
> +	}
>  
>  	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
>  	if (rc)
>  		return rc;
>  
>  	tpm_buf_append_u32(&buf, handle);
> -	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
> -	if (rc == TPM2_RC_SUCCESS)
> -		rc = tpm2_parse_read_public(name, &buf);
>  
> -	tpm_buf_destroy(&buf);
> +	rc = tpm_transmit_cmd(chip, &buf, 0, "TPM2_ReadPublic");
> +	if (rc) {
> +		tpm_buf_destroy(&buf);
> +		return tpm_ret_to_err(rc);
> +	}
>  
> -	return rc;
> +	/* Skip TPMT_PUBLIC: */
> +	offset += tpm_buf_read_u16(&buf, &offset);
> +
> +	/*
> +	 * Ensure space for the length field of TPM2B_NAME and hashAlg field of
> +	 * TPMT_HA (the extra four bytes).
> +	 */
> +	if (offset + 4 > tpm_buf_length(&buf)) {
> +		tpm_buf_destroy(&buf);
> +		return -EIO;
> +	}
> +
> +	rc = tpm_buf_read_u16(&buf, &offset);
> +	name_size_alg = name_size(&buf.data[offset]);
> +
> +	if (name_size_alg < 0)
> +		return name_size_alg;
> +
> +	if (rc != name_size_alg) {
> +		tpm_buf_destroy(&buf);
> +		return -EIO;
> +	}
> +
> +	if (offset + rc > tpm_buf_length(&buf)) {
> +		tpm_buf_destroy(&buf);
> +		return -EIO;
> +	}
> +
> +	memcpy(name, &buf.data[offset], rc);
> +	return name_size_alg;
>  }
>  #endif /* CONFIG_TCG_TPM2_HMAC */
>  
> @@ -243,6 +251,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
>  	struct tpm2_auth *auth;
> +	u16 name_size_alg;
>  	int slot;
>  	int ret;
>  #endif
> @@ -273,8 +282,10 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  	    mso == TPM2_MSO_NVRAM) {
>  		if (!name) {
>  			ret = tpm2_read_public(chip, handle, auth->name[slot]);
> -			if (ret)
> +			if (ret < 0)
>  				goto err;
> +
> +			name_size_alg = ret;
>  		}
>  	} else {
>  		if (name) {
> @@ -286,13 +297,8 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
>  	}
>  
>  	auth->name_h[slot] = handle;
> -	if (name) {
> -		ret = name_size(name);
> -		if (ret < 0)
> -			goto err;
> -
> -		memcpy(auth->name[slot], name, ret);
> -	}
> +	if (name)
> +		memcpy(auth->name[slot], name, name_size_alg);
>  #endif
>  	return 0;
>  
> 

This will apply on top of https://lore.kernel.org/linux-integrity/aV-kD5iKi9fwluU0@kernel.org/T/#t

BR, Jarkko

