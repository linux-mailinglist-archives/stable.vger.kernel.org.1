Return-Path: <stable+bounces-213278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBe2B2kkgmnPPgMAu9opvQ
	(envelope-from <stable+bounces-213278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:38:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D42DDC158
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC9913009F22
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8D3D3019;
	Tue,  3 Feb 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z2KUZZOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0E318B9E;
	Tue,  3 Feb 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136673; cv=none; b=Pju/P+eBm4xzzAt+PKPJ83SbuzuNqFCB7WbyokmQAyctKCxixOLiAHHtrq8mUPumGCZEMno8LRcP1fSRG0EdhapX9EEl/gjkpUjP+K3N7zB2l1021OcuRuzMbhtvIqv9QhxI6yp7W3i6si/GiW9I5NDTQ9IP0wZkO9do176C1h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136673; c=relaxed/simple;
	bh=rOKpqdPFYggKJpVAU6wtXwf20Rvom0J8VquNYFXXENc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOBG3MQZ0c/SbHJaY0MXoIhw7GKR+XxK1mGYRdh9de5ez3++VMTI9xzzyVMxIcWZXXTD1P0LQFWF+s8Ryz9G4WdOmg+AUhVdjkv/mKW46x2q8gwtG+wTziia05pAZOABLB4oDQYayCJ8wwGPqIEsCTVmCs5PmFAn97rEptLOSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z2KUZZOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B318BC116D0;
	Tue,  3 Feb 2026 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770136673;
	bh=rOKpqdPFYggKJpVAU6wtXwf20Rvom0J8VquNYFXXENc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z2KUZZOxKyL/VB8C8JZj8E68RxyNC/hSBr1iHg1KFY2Sd4Zb4YBO8PUAnLkSHPCiJ
	 7YEW7kTfPZUS5cWkGi1fjm+oZAxOnfUlVy7h4CCetXoYJxzC7F9rxFp6Ioy75omyvI
	 BcnSBDUkUzakPDT689X4Jw6dpeYXuF8DZfZ9CS3w=
Date: Tue, 3 Feb 2026 17:37:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David =?iso-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, Zeng Heng <zengheng4@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 5.10] net: mdio: fix unbalanced fwnode reference count in
 mdio_device_release()
Message-ID: <2026020318-affected-irritate-cda7@gregkh>
References: <20260116-backport_cb37617687f2_20260115100804-v1-1-9796615d93ab@est.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116-backport_cb37617687f2_20260115100804-v1-1-9796615d93ab@est.tech>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213278-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,kernel];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[710700c0:email,huawei.com:email,0.0.0.4:email,armlinux.org.uk:email,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,est.tech:email]
X-Rspamd-Queue-Id: 1D42DDC158
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 11:14:45AM +0100, David Nyström wrote:
> [ Upstream commit cb37617687f2bfa5b675df7779f869147c9002bd ]
> 
> There is warning report about of_node refcount leak
> while probing mdio device:
> 
> OF: ERROR: memory leak, expected refcount 1 instead of 2,
> of_node_get()/of_node_put() unbalanced - destroy cset entry:
> attach overlay node /spi/soc@0/mdio@710700c0/ethernet@4
> 
> In of_mdiobus_register_device(), we increase fwnode refcount
> by fwnode_handle_get() before associating the of_node with
> mdio device, but it has never been decreased in normal path.
> Since that, in mdio_device_release(), it needs to call
> fwnode_handle_put() in addition instead of calling kfree()
> directly.
> 
> After above, just calling mdio_device_free() in the error handle
> path of of_mdiobus_register_device() is enough to keep the
> refcount balanced.
> 
> (cherry picked from commit cb37617687f2bfa5b675df7779f869147c9002bd)
> 
> Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Link: https://lore.kernel.org/r/20221203073441.3885317-1-zengheng4@huawei.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: David Nyström <david.nystrom@est.tech>
> ---
> This series backports 1 commit(s) to the 5.10 stable tree.
> ---
>  drivers/net/mdio/of_mdio.c    | 3 ++-
>  drivers/net/phy/mdio_device.c | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
> index b254127cea50..355c3ee21cd7 100644
> --- a/drivers/net/mdio/of_mdio.c
> +++ b/drivers/net/mdio/of_mdio.c
> @@ -168,8 +168,9 @@ static int of_mdiobus_register_device(struct mii_bus *mdio,
>  	/* All data is now stored in the mdiodev struct; register it. */
>  	rc = mdio_device_register(mdiodev);
>  	if (rc) {
> +		device_set_node(&mdiodev->dev, NULL);
> +		fwnode_handle_put(fwnode);
>  		mdio_device_free(mdiodev);
> -		of_node_put(child);
>  		return rc;
>  	}
>  
> diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
> index 797c41f5590e..f72d18ee2792 100644
> --- a/drivers/net/phy/mdio_device.c
> +++ b/drivers/net/phy/mdio_device.c
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/unistd.h>
> +#include <linux/property.h>
>  
>  void mdio_device_free(struct mdio_device *mdiodev)
>  {
> @@ -30,6 +31,7 @@ EXPORT_SYMBOL(mdio_device_free);
>  
>  static void mdio_device_release(struct device *dev)
>  {
> +	fwnode_handle_put(dev->fwnode);
>  	kfree(to_mdio_device(dev));
>  }
>  
> 
> ---
> base-commit: f964b940099f9982d723d4c77988d4b0dda9c165
> change-id: 20260115-backport_cb37617687f2_20260115100804-bb6cefe39d44
> 
> Best regards,
> --  
> David Nyström <david.nystrom@est.tech>
> 

Breaks the build, how did you test this:

drivers/net/mdio/of_mdio.c: In function ‘of_mdiobus_register_device’:
drivers/net/mdio/of_mdio.c:172:35: error: ‘fwnode’ undeclared (first use in this function); did you mean ‘inode’?
  172 |                 fwnode_handle_put(fwnode);
      |                                   ^~~~~~
      |                                   inode


