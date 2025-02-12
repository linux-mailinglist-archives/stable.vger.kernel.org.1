Return-Path: <stable+bounces-115054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CABA32785
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 14:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16017A319C
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB1205ABC;
	Wed, 12 Feb 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dQ61uXg/"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD41C695;
	Wed, 12 Feb 2025 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368192; cv=none; b=QVwFpPjka2t7945jvl24XtA/GDgtHh/5Tahx3RMDtEH9Z6JHxjSIe7brPO7jSZyzYU5x1eN/Y0tpwMPRFsovr9bqxwIJTFUTPfa1QV8riJexMuOTqHO4YPtDvnW13JlNue31UYdV9q9bvPxd4LKnP/nNft0NiFlLB61X26lR15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368192; c=relaxed/simple;
	bh=RcEvR6kg6kxofvCyZBw+YcQC8qJGSVlA6wGyaOGGXVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fe5Ls93O3VCzmWEqQo3UVNeJnLf4kvL85M7cng3EgX5SuPYV9QTM0BgeIMiODQHC5zPUlOUgexkVtaFz+SdfLwl+cYl1e3tUW77V6oXZUoW6FCreR8ae6YbLg+9x1TCYfcWRTwhgR9s90hcASG7m7p4mD/EZt/eTvx0+9Y/fOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dQ61uXg/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V8awgjnRjIsQYZrQ1w+BZZzdEbNxt1fTjOjgKBl+PTA=; b=dQ61uXg/y0xbYja2bf7zcT/eVR
	zapLmhSRz5uBvVcFNUDd+FGSKT1XYRt65ZGx9yYTNQE2UjzMajSjXy6ntPXGIVQETeEi9r1EGhvGd
	0NxNkxkoZrqwEPu3cQ561OSAW7fs49NlMDif0v764+I2bWTZ++ZKLDxeZbkEiJVk/dMQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiD7S-00DPPM-4W; Wed, 12 Feb 2025 14:49:38 +0100
Date: Wed, 12 Feb 2025 14:49:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: microchip: sparx5: Fix potential NULL pointer
 dereference in debugfs
Message-ID: <86cd2c99-7006-4ce1-abb1-8fe5e535fedb@lunn.ch>
References: <20250212091846.1166-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212091846.1166-1-vulab@iscas.ac.cn>

On Wed, Feb 12, 2025 at 05:18:46PM +0800, Wentao Liang wrote:
> In vcap_debugfs_show_rule_keyset(), the function vcap_keyfields()
> returns a NULL pointer upon allocation failure.

/* Return the list of keyfields for the keyset */
const struct vcap_field *vcap_keyfields(struct vcap_control *vctrl,
					enum vcap_type vt,
					enum vcap_keyfield_set keyset)
{
	/* Check that the keyset exists in the vcap keyset list */
	if (keyset >= vctrl->vcaps[vt].keyfield_set_size)
		return NULL;
	return vctrl->vcaps[vt].keyfield_set_map[keyset];
}

I don't see any allocations here which can fail. I do agree it can
return NULL thought. So you code change looks correct, but you commit
message is broken.


    Andrew

---
pw-bot: cr

