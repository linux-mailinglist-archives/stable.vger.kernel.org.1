Return-Path: <stable+bounces-253752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC2rNg82EGorVAYAu9opvQ
	(envelope-from <stable+bounces-253752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:55:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFCA5B28AF
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4131230E5054
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A883FCB1A;
	Fri, 22 May 2026 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nTmUck+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F93D25D7;
	Fri, 22 May 2026 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445441; cv=none; b=m1CzFTQpp2AXFjy7klrHZ7+jnspK5rteV5L6tasIq4FNLZPdj3VmTQW6flnjXEKM/wuxYdM8ysHbjwE4rJZn/yHf0g1OQUdZvDVuGcECava5FZR6IhUjnc2pmKpfZ24Dy4DV3AS/+Ooyu4Kt+UMkaI2Xu9uYDk5xMLUsA7UNNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445441; c=relaxed/simple;
	bh=erBG5BvKCe+MIFcZ+3w2qYG7/6BjnB7j4GI7RzhtL5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOl+z28OuRTnnI3ZvlRifb/zfPWYOOo7xS1h5+ihIH9VSZm4xOKbVcXN1vU4kFZcMNDcVfL5lFgdDBPZ5X7CS9YEBYboQPQlhHfcEaweeHAtwrtmVd+mq1Dp4jni+IDRKrNZOJ0zZTliPe72y8WbbH+ABh3+cs1FhQvNDVcQtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nTmUck+L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1783E1F000E9;
	Fri, 22 May 2026 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779445439;
	bh=Xv8ZoUoS/zmnRcAbOAXWRel8m5XtyLI16d4nRsrnI1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nTmUck+LhIpK9r8rRtBbMEOs+FFOJ/ok5cPw1PQ5XoNwZbkf6MoIRc9Fo9rfvyM2L
	 WdaC6iS0yQuocDO7rBhfM4i+QTqKZIFfiBk/Qre9+12g9grJ3xGUvEKWYbejVKiyM5
	 gTNTwJDxSUKK8OWOmNUaRf3yCbyIwpDVaki3A7BU=
Date: Fri, 22 May 2026 12:24:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	brgl@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in
 fwnode_init()
Message-ID: <2026052254-rug-mug-24cd@gregkh>
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
 <DICUSYTHZ339.3DW3CRNZ32K6U@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DICUSYTHZ339.3DW3CRNZ32K6U@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253752-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linux.intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EAFCA5B28AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 08, 2026 at 02:03:44AM +0200, Danilo Krummrich wrote:
> On Wed May 6, 2026 at 1:57 PM CEST, Bartosz Golaszewski wrote:
> > If a firmware node is allocated on the stack (for instance: temporary
> > software node whose life-time we control) or on the heap - but using a
> > non-zeroing allocation function - and initialized using fwnode_init(),
> > its secondary pointer will contain uninitalized memory which likely will
> > be neither NULL nor IS_ERR().
> 
> I see why secondary is generally more prone to this, but if the justification of
> this change is to not rely on the caller to zero out the memory, then we might
> just want to initialize all fields.
> 
> For instance, if the caller is allowed to not zero-initialize the memory then
> having flags with a random value isn't correct either; all accessors are atomic
> bitwise operations that never zero the whole field.
> 

Sure, but for now I'll go take this one.

thanks,

greg k-h

