Return-Path: <stable+bounces-267077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pwRJHei6M2o/FgYAu9opvQ
	(envelope-from <stable+bounces-267077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:31:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2D69EE3D
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:31:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pschenker.ch header.s=20220412 header.b=QZkCmAOa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267077-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267077-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=pschenker.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26396301EC04
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD333BED59;
	Thu, 18 Jun 2026 09:30:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD333DB645
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 09:30:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775058; cv=none; b=c6ZKY9Y0SI2/frukS0vncrITgY3e6i3rNK/LlUm85E3hPcGN5G7eVbnhYbooFKiiz3Pgfk5pbsNZiGn66SLBEUMseysvN0FxVijgz2P7hl6PV+xqNrGnUM2m9mR90gIULdwS7jPsgDi5U1u19kgMlRQBr2DPoCIviE9v1xnS+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775058; c=relaxed/simple;
	bh=dB0Vq19/pojtzKMdhU+ZjSekw7vileLMRuihFiNJgbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qgp2DkYT8ESrYV1K23ToR6TWA9ojBS1XHAc/GWKE63y/C+LQY3oTLfjY8sViyJ4IKJqBWoMC5fIkywEwT56nVT+maEEPkFJPS0byPGfQMVhwqGnp6G+DaF/4v7AnKXl55plGXF3ZG7hg6aOXNmetX2iy2kObJObXjxQIY74R3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=QZkCmAOa; arc=none smtp.client-ip=185.125.25.14
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ggwSm30plzg4l;
	Thu, 18 Jun 2026 11:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
	s=20220412; t=1781775048;
	bh=dB0Vq19/pojtzKMdhU+ZjSekw7vileLMRuihFiNJgbY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QZkCmAOaWPmGsisoVV7yHqc53vNnggu3Bg6/wYzJCYSgrPjBlmb/6HqOCH9HtFeq1
	 /oRHdXW3gab/eEdvxtLK+1V8QVwnAgC9tYBywtlMGqYamMHLA6yboVopbf8tiJVjxQ
	 sL/zRJUCBVWwLL8fkWBN2vWfTWGK0oP4O6u9NTbE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ggwSk2kZbzmC6;
	Thu, 18 Jun 2026 11:30:46 +0200 (CEST)
Message-ID: <ecb210fddc9f0926c98d682e8ffbf99defa05991.camel@pschenker.ch>
Subject: Re: [PATCH net] net: ethernet: ti: icssg: guard PA stat lookups
From: Philippe Schenker <dev@pschenker.ch>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, danishanwar@ti.com, rogerq@kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, Andrew Lunn	
 <andrew+netdev@lunn.ch>, David Carlier <devnexen@gmail.com>, "David S.
 Miller"	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jacob
 Keller	 <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Kevin
 Hao	 <haokexin@gmail.com>, Meghana Malladi <m-malladi@ti.com>, Paolo Abeni	
 <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2026 11:29:24 +0200
In-Reply-To: <20260618091004.GG827683@horms.kernel.org>
References: <20260616143642.1972071-1-dev@pschenker.ch>
	 <20260618091004.GG827683@horms.kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-b4MkfBcVTcys+AbJZKR4"
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pschenker.ch,none];
	R_DKIM_ALLOW(-0.20)[pschenker.ch:s=20220412];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267077-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[dev@pschenker.ch,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,kernel.org,lists.infradead.org,lunn.ch,gmail.com,davemloft.net,google.com,intel.com,redhat.com,linux.dev];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:andrew+netdev@lunn.ch,m:devnexen@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:haokexin@gmail.com,m:m-malladi@ti.com,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@pschenker.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[pschenker.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ti.com:email,vger.kernel.org:from_smtp,impulsing.ch:email,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70D2D69EE3D


--=-b4MkfBcVTcys+AbJZKR4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon

Thanks for the review and I'll send a v2 with that blank line removed.
Saw it right after sending the patch.

Philippe

On Thu, 2026-06-18 at 10:10 +0100, Simon Horman wrote:
> On Tue, Jun 16, 2026 at 04:35:34PM +0200, Philippe Schenker wrote:
> > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > icssg_ndo_get_stats64() unconditionally calls
> > emac_get_stat_by_name()
> > with FW PA stat names regardless of whether the PA stats block is
> > present on the hardware.=C2=A0 emac_get_stat_by_name() already guards
> > the
> > PA stats lookup with `if (emac->prueth->pa_stats)`; when that
> > pointer
> > is NULL the lookup falls through to netdev_err() and returns -
> > EINVAL.
> > Because ndo_get_stats64 is polled regularly by the networking stack
> > this produces thousands of log entries of the form:
> >=20
> > =C2=A0 icssg-prueth icssg1-eth end0: Invalid stats FW_RX_ERROR
> >=20
> > A secondary consequence is that the int(-EINVAL) return value is
> > implicitly widened to a near-ULLONG_MAX unsigned value when
> > accumulated
> > into the __u64 fields of rtnl_link_stats64, silently corrupting the
> > rx_errors, rx_dropped and tx_dropped counters reported by `ip -s
> > link`.
> >=20
> > Every other PA-aware code path in the driver is already guarded
> > with
> > the same `if (emac->prueth->pa_stats)` check.=C2=A0 Apply the same guar=
d
> > here.
> >=20
> > Fixes: 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats")
>=20
> nit: no blank line between tags
>=20
> >=20
> > Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > Cc: danishanwar@ti.com
> > Cc: rogerq@kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: stable@vger.kernel.org
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

--=-b4MkfBcVTcys+AbJZKR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmozunUACgkQjRDjR2ho
XxorIgv+MdrlIU+2xGujhlcXTn+Dsq0kw33yjB3erdz6HBgq+DdEkIa0y70uv3T2
MqpKAYE3rPZQ3S8fZWhmzeJAFFXTgVF+G9XANpH9K3f0GClORwvNfjKfeS6sbbo3
9eg+iiQbKUSRBp6gYmAWySaaVXtu1rl4dWav4PBpHz+E8psyn7gsdBTePWozMhSe
g9LI+eN8dt9j3khhcaSNQYulCe3GGomP5akVXTDNgYZo3fksJtoYX1r5wgYk78Ni
UGBZHDol//C/rhpSGh7OF/HkBhz0ALZ6ceA+HzfCMwbJWy8IStRHtmMVBUEg+jZC
sgJM8IRw5KRzVtp2N48ZgjYH3nryykpheySI+Rp9c7ZnY0Jqf+vDjS3ucjPUEmSk
XherZhqhT0+nE4eaYJDNU+F/QudOvMHSYH+sk3mnCjpuGdOai8BDdhV+oq1Ql0LV
W17nyWFwwmtgSQKbR3NV537nWIzKGqz5PEcHye6GowHRoTeH1rbLPSFYaIbPEvbd
kgjvWlmW
=KfCZ
-----END PGP SIGNATURE-----

--=-b4MkfBcVTcys+AbJZKR4--

