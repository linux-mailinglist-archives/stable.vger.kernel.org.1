Return-Path: <stable+bounces-260497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bNwuGluBIWpnHgEAu9opvQ
	(envelope-from <stable+bounces-260497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 15:44:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F464073D
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 15:44:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lzjhVjbu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260497-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260497-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56094308E684
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24C47DF8D;
	Thu,  4 Jun 2026 13:43:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD947DD65
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:43:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580622; cv=none; b=Wb7uer9cQ1TyPY0iZqKG4gevz8vPfL8nG+XLpSzhIdsCB6hf9USXmZg89K2MfUAScVPOBZionB15HyFtbALO2xcOzGch6XIkluc4UL3ZFHrRS+bCtHzLMHzN9wkG4fd8pT2zrFS5FdTLchRRDPbdhbpOJP2Q0ZFBIk0INhCtxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580622; c=relaxed/simple;
	bh=CToxS6FdlZj4zouJ7vHNbDLfrpqXFrgnLw/ve1kfXX4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yad966BtVO26Tjg+WPZXuS8seI/fXxS9NItgDNtCZsoMFiWk32tnwWxkq07QgTEL/Vd7M9pWcYCOfv8R5Iv/0nAI/kv6XjpzuTHFtVmr6cuubTPcjUdEoqwv1wTyOJv0Oi7dMvli3v+elXNd5mbjUq36v3w2ABwnAWDLowAH7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzjhVjbu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D801F00893
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580621;
	bh=N1YAyS3TGKktpEHhVLzBCoJrDFUddxGXi3xr4lYxQ/Q=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=lzjhVjbuLVvuRPCh3ZYoDj3Vz3gaa76R02sVOPDwerevvvaxtomBugxWOaluL3TWR
	 sXwGr6xbtk6Pd8TLA9GbIbg33d2nnLVatmdAGxA3ioYFVI9qowrIP323WNaL543f3S
	 89EgLPcn9DS+lLGlQl+46S0CxWAToNJ0mQm7KGLHtdwE+fYPOrbmZXh8DLgJ4qEloS
	 88FvexxVNgLdVFrbGWtU5jIHmk4ReW6D1qv9pD718lIHJMwf4YZS8+xOvzaMT6lYje
	 e2fARk4dWpE8ZRxuEMmX51Pm5OdTLoHuiOQ3NfxvN97cCQM82X4tFyJ4DnHbYNlp2i
	 v57lml76gHOQA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39676d82b7fso7569181fa.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 06:43:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/u9w2c0PQF+bLq7CoaXNQ1+5z3M9rIjgSR87+t+jWW842pKIoARSAxWPAq0f3xhDXoqAWtTwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxor+R7U24vkVExYQnTm+Xg0sHyTn7oElAV/mbHqtI5+5q4HBKh
	plWGRN39gOvQmb92CkdKFUtHRrTIzblQi6oTRkEGRWf27riQaQ2jXUKhBGNLI+AuK/2UEVrId7s
	agXU1dTg8pwtwfgBisMuRjvqQmZz+0q/rbkQ4MjXM+Q==
X-Received: by 2002:a05:6512:131f:b0:5aa:73e5:3570 with SMTP id
 2adb3069b0e04-5aa7c0cec6dmr2678551e87.36.1780580619850; Thu, 04 Jun 2026
 06:43:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 06:43:38 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 06:43:38 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <x5liep46c3yzqh3wfsfa2euku6j6yka32clpiwf2zkqdm6czds@b2rll3k67yhd>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-2-0ae381f8b7b9@nxp.com>
 <ah_5NgZPc2U0_FPO@ashevche-desk.local> <x5liep46c3yzqh3wfsfa2euku6j6yka32clpiwf2zkqdm6czds@b2rll3k67yhd>
Date: Thu, 4 Jun 2026 06:43:38 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeV=FcojNs6rJoBcCwWoDKe5Dwc4MXrHSzEMdHin6j+BQ@mail.gmail.com>
X-Gm-Features: AVHnY4IEdPcUDSy4usLTi2dyhCYEs9OtptwMsFAhF1KOZVfa8Akr_l_ig2kFsV4
Message-ID: <CAMRc=MeV=FcojNs6rJoBcCwWoDKe5Dwc4MXrHSzEMdHin6j+BQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] device property: fix infinite loop in fwnode_for_each_child_node()
To: Xu Yang <xu.yang_2@oss.nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260497-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xu.yang_2@oss.nxp.com,m:brgl@kernel.org,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:mchehab+huawei@kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-acpi@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:xu.yang_2@nxp.com,m:stable@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,m:mchehab@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.intel.com,linuxfoundation.org,ideasonboard.com,vger.kernel.org,lists.linux.dev,nxp.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 091F464073D

On Thu, 4 Jun 2026 13:05:23 +0200, Xu Yang <xu.yang_2@oss.nxp.com> said:
> On Wed, Jun 03, 2026 at 12:51:50PM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 03, 2026 at 04:44:32PM +0800, Xu Yang wrote:
>>
>> > When iterate over children of a fwnode that has a secondary fwnode,
>> > fwnode_get_next_child_node() can enter an infinite loop if the seconda=
ry
>> > fwnode has more than one child.
>> >
>> >                        Parent        Child
>> >       (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
>> >     (Secondary fwnode)   FWb:   {FWb1, FWb2}
>> >
>> > In this case:
>> >
>> >  =E2=94=8C=E2=94=80> fwnode_get_next_child_node(FWa, FWa1)
>> >  =E2=94=82    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) ret=
urns FWa2
>> >  =E2=94=82
>> >  =E2=94=82   ...
>> >  =E2=94=82
>> >  =E2=94=82   fwnode_get_next_child_node(FWa, FWa3)
>> >  =E2=94=82    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) ret=
urns NULL
>> >  =E2=94=82    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) ret=
urns FWb1
>> >  =E2=94=82
>> >  =E2=94=82   fwnode_get_next_child_node(FWa, FWb1)
>> >  =E2=94=82    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) ret=
urns FWa1
>> >  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>> >
>> > This cause fwnode_for_each_child_node() to loop indefinitely, reapeate=
dly
>> > output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.
>> >
>> > The root cause is that when the current child (FWb1) belongs to the
>> > secondary fwnode, calling get_next_child_node() on the parimary fwnode
>> > incorrectly returns the first child (FWa1) again instead of NULL.
>> >
>> > Fix this by dynamically checking the parent fwnode of the current chil=
d
>> > before calling get_next_child_node(). This approach follows the patter=
n
>> > established in commit b5b41ab6b0c1 ("device property: Check
>> > fwnode->secondary in fwnode_graph_get_next_endpoint()").
>>
>> ...
>>
>> TBH, this code becomes twisted and complicated. Can we add some test cas=
es to
>> show the problem? Also we need to add other possible combinations (somew=
hat
>> about ~5-6) of the different types of fwnode in a relationship.
>
> I agree that adding test cases would be helpful. But It's not straightfor=
ward to
> get swnode refcount as swnode is an internal structure. Any suggestions o=
n this?
>

You should be able to replicate the problem with the firmware node API with=
out
accessing the internal swnode structure. You can use dummy OF nodes as the
primary fwnodes.

Bart

