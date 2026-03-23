Return-Path: <stable+bounces-227875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGjvOCeawGmJJAQAu9opvQ
	(envelope-from <stable+bounces-227875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 02:40:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA972EB894
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 02:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA129300360C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9AB1EE7D5;
	Mon, 23 Mar 2026 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yld0IW9N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB01F0E25
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230053; cv=none; b=tVF3XYxEQxldsdaD9MEE1vY35dDpniOclm1df64IkbOvtMPy2Z5gh3MOR5iDNmX2Qqo2RZpgoJzCB7iRq9Bt9VZDYsVsjKQ18yZmP7GhdqDxdNfkue2FE3919N1uDmGjrfSg0Q7barmuHas1lw5AHM0qGZ03KdbBObrWYaRg1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230053; c=relaxed/simple;
	bh=c4vg/yrkkoYodLTyK73OjzTRN+kuxvBTfJWAD/iCs7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMYNTRIr94u3NuC/+D7JU/DRjVHfaWB5gzI2pWrVPYQVKAOpuC9BMqQYL45bKLIAt5NDTjB2vyQhzX8snBNoDNHGZYhJJCzV+NgP7jtlJzhvXPoqMzVgQVxdPtalt1U6C5L4NExeIW3HBWqvRR3tz5kBAgP6JQLS5J9M519pThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yld0IW9N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aecc6b0861so20457405ad.2
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230052; x=1774834852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLt09SP0vtOYo03XHu6SC4VMmvfGM5f6co6uv+DFIx8=;
        b=Yld0IW9N44V/PyCUaC1/ZTg/DDgyZ3CAQtRgpGXsDAfCehSGBx/2u5Pk/pWPNzBVqt
         eWUVscVkQF30CEOd87w/IGgKpuS7k1+F0vX+7ybTScAb27NDjuJe976xwRt0jqgjrQdO
         oowf170Gpo+sn/oSvMIllc9fJsoI3NqDB55sD96ZP5oIcz8qb6NFyLnQVVVGXm8ZclUN
         NBo/Ohh+DHaDLrPXG3YeIPz8S2218mF3bydBVLaz22n+fQDe593+Q4jK8tHrZ63W/RWy
         jhcZh0ALV50kNw0uK9aJMniaM5fiIxegffbYiSqzNp+yseRCUmiJfxAlOk4ieCX4we9O
         rxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230052; x=1774834852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DLt09SP0vtOYo03XHu6SC4VMmvfGM5f6co6uv+DFIx8=;
        b=tF9ng5U5B86owYo5llh55JYzfwJo6CIMDN2gZiBJK874dzWgmBLaO5qp3/viQ7NuY/
         zTx69J0DQJaW3cLFYRC1VN3nGRNSgxUrKqDftM1U/xmMM2qGO5ovNgqABiJYBkmENod0
         PKV1rJtBjuveRyNeO43LUpnvqSkbsQqwqh8fvW0q0M2BEvUhtionb4ReT6roVVLBhBiQ
         KuhzbB+ffVR+tssrqvJ4pBS0aVDpcS8aazNQBBrMNmpVRfNzZhhd4nIaWh/t4yPYt7cG
         OhK2if6dNPgnePYgp8lne82IoBUaOR2/cVk+irghjM21c5Pq68i5S6kolP/RQrEMNQOT
         9GVg==
X-Forwarded-Encrypted: i=1; AJvYcCXbp0i7c2V7ab7taJ3zwVI1JEV0rAjc4/1+Xo0AWc2MDt4Gv2/9o4fRoC3uN+2LZpTWtWKk5AA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mTE/CHqVE3zEyuIMvd/umiL4e/jAS4riv2Vd6ZmzBb2ehClq
	7w8W+zs6pOxdBS8TljXxlcvW6Frz9f+q1dqm/KwuINxVNjJqt9bVEopaJybg7A==
X-Gm-Gg: ATEYQzz0+nJm0S/8w9bViQ4HyOOiJJcZh9yhfMuTbAb/QWapxQJWqJ1H38ePYAQYH5c
	PWc5r09NrSp5LLjtUsiqT/c36Jtcfz/w/2y2Ln5xrQ8eHLq4NdKKlm/TqU8hmPd0pijDLuQWj+v
	L3OSVWir0IvS6NKat1oGWud0v/EvfaEYAQ53cJtnSAcuHOvU01uOG7ZDS1jlnHKzF5cc8x2hEgi
	DKNG7qlGZvsfaX7oAqccs2M5ySj+6JMd8UgvzEweq84ENIITJHAuKgNyJeruecuU+3srg1J8egt
	vJcoadbidCsoa8eDX/oV45W3/MDvMFBvk6YNlV8Q8nFPyzCRbLSDvjmDyYPZAGSw8+GhL7WVaAz
	e2gbY633R4gM8BGK63W9810UzaxwYd+7tgZMTASOTb2SDEMAhP2x5G2/V9jicXWLx5vHL/C0LoA
	XlFiDAl2Q7gb0F7ol9p+LGMDhbKyFaxWe3J4in
X-Received: by 2002:a17:902:e5ce:b0:2b0:4f82:74ca with SMTP id d9443c01a7336-2b082826cf1mr89062095ad.53.1774230051814;
        Sun, 22 Mar 2026 18:40:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b6dc8sm94873195ad.82.2026.03.22.18.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:40:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 22 Mar 2026 18:40:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"iwona.winiarska@intel.com" <iwona.winiarska@intel.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (peci/cputemp) Fix off-by-one in
 cputemp_is_visible()
Message-ID: <36950a5e-476d-412e-8f3f-da74e6e5303b@roeck-us.net>
References: <20260323002352.93417-1-sanman.pradhan@hpe.com>
 <20260323002352.93417-3-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323002352.93417-3-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-227875-lists,stable=lfdr.de];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid]
X-Rspamd-Queue-Id: 8FA972EB894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:24:37AM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> cputemp_is_visible() validates the channel index against
> CPUTEMP_CHANNEL_NUMS, but currently uses '>' instead of '>='.
> As a result, channel == CPUTEMP_CHANNEL_NUMS is not rejected even though
> valid indices are 0 .. CPUTEMP_CHANNEL_NUMS - 1.
> 
> Fix the bounds check by using '>=' so invalid channel indices are
> rejected before indexing the core bitmap.
> 
> Fixes: bf3608f338e9 ("hwmon: peci: Add cputemp driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

