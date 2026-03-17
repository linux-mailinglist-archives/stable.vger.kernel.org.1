Return-Path: <stable+bounces-226121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC5YAJl/uWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:21:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C32ADDA0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E32C303E1D9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B230EF84;
	Tue, 17 Mar 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWwY5lgx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCD246BC6;
	Tue, 17 Mar 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764459; cv=none; b=qX9kp40zmpemQqZW2PyQaT96F5T0eRXHgntyDLP9LY8n/kSMsdJuZ1VS7qyCjwqGjwYk6GUmr5bRTpPz6Czi6CTkNN+HcmH8lnFtv0w9fedg5VZHWcyLze8huwbYDMnHw8N1fXSmiG9o2Zg4GsmM3CdFMNiUeasJznRSb8z27Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764459; c=relaxed/simple;
	bh=e0BPQ1p0UdfRCxCsTaN9DCxBuEgVgdYt0iMgNM1/M1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lM6F9T6KjNSF8AEUBkVzYqrsemHZ1PxYuN2/jTdip5ent0NDgyWaIq37SNaIiHpdSf7APqytHVunhINr8GonVg6fIfGTEqHaOKSmWGBrBxwBi252MrMPTyj+ib7o3ZIikPeiFVCwlHFHDkyH543ZgYUl9IFMJ+KNd4sDfRgRS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWwY5lgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775A7C4CEF7;
	Tue, 17 Mar 2026 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764458;
	bh=e0BPQ1p0UdfRCxCsTaN9DCxBuEgVgdYt0iMgNM1/M1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KWwY5lgxEUOSMGbdv+aQWxJp08HLMO7z3TQgBQ1a0RAkOkA+HhoC66RreUnEdoqVv
	 f/Cj0g3xYmLRHrgQZGCWbPRlyy12meMkzl61LsRz54Zu073r6Ct7QpcsIhxHEwwEYd
	 tpszZOw4aqVoCCSO8A1hDIi7Cx2lQ1cniaOFqORXExZjrvwcId9xfPi9od081znGp0
	 j3AlD3Vxh84yMQGKBBsYSIgnfRb2FPxk0OmYjc2c+6MctKviHVjF5wfUby36SiQxnP
	 zVQJz5jotHJhQosIBbAGv0xdxeJq969llKUbN+YrfDoOUB7H3IvqF6IK1UiyqIqhT+
	 ThoDGXHmVugpA==
Message-ID: <0f92ab73-5996-4977-9ada-e8a26957110c@kernel.org>
Date: Tue, 17 Mar 2026 17:20:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn
 <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Saravana Kannan <saravanak@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
 driver-core@lists.linux.dev, imx@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, netdev@vger.kernel.org
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CAJZ5v0hwO16=mP_vB=wi7x8CjROAw_Nd_Tq-hEohrDW3C58RbA@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hwO16=mP_vB=wi7x8CjROAw_Nd_Tq-hEohrDW3C58RbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226121-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,linuxfoundation.org,vger.kernel.org,linux.intel.com,kernel.org,sang-engineering.com,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:email,sang-engineering.com:email]
X-Rspamd-Queue-Id: D33C32ADDA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/2026 5:11 PM, Rafael J. Wysocki wrote:
> On Tue, Mar 17, 2026 at 5:04 PM Douglas Anderson <dianders@chromium.org> wrote:
>>
>> In various places in the kernel, we modify the fwnode "flags" member
>> by doing either:
>>   fwnode->flags |= SOME_FLAG;
>>   fwnode->flags &= ~SOME_FLAG;
>>
>> This type of modification is not thread-safe. If two threads are both
>> mucking with the flags at the same time then one can clobber the
>> other.
>>
>> While flags are often modified while under the "fwnode_link_lock",
>> this is not universally true.
>>
>> Create some accessor functions for setting, clearing, and testing the
>> FWNODE flags and move all users to these accessor functions. New
>> accessor functions use set_bit() and clear_bit(), which are
>> thread-safe.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Rafael J. Wysocki (Intel) <rafael@kernel.org>

ACK or RB?

