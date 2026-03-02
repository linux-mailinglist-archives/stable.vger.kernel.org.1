Return-Path: <stable+bounces-222499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xUboMbDjpGmquwUAu9opvQ
	(envelope-from <stable+bounces-222499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 02:11:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1331D23AD
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 02:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15B23013AB3
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 01:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9301DE2B4;
	Mon,  2 Mar 2026 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0YZ49CiR"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DE75809
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772413867; cv=none; b=IoPhci/UEM9ht0H0eDq2xcY67EVUkfZLidU7tq0dnkgAXeqAX9FHVzFKPhdSx6knogaohBYTKbTdJB3jueJ3LnXi02vTi0RSUs2xhlWV8wSmODi7pixafXwsXZcUHSmKp2ElSbcb7o+vx9AczC7JyMpyBAOLVbsCZ7slyIyrhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772413867; c=relaxed/simple;
	bh=WuNhENcX1fJwfoNDpI8nYniFOrFTNC2cD+1g8RgYTgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMgn5gIvh4+z1+/KKCt3A+Dim0dNl+r8WIi+DOrFNHgWjifjaESehjBQS0B1jP3M6L5g76Kf2rapFu/MFV5qkvXjgbsy5tDRYGWy7TAzJkl36kdhCAoS+Sdq4sxDPV+QtbvOznpVhn5dbHod2gVlH2PIu0MpKVfiro+CxOBn9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0YZ49CiR; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271257ae53so4509274c88.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 17:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772413865; x=1773018665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLzx4QloOR7w220ELbFdJo9+YB2Xr38O5JizyVmv14A=;
        b=0YZ49CiRYI+llU7OGK0XJsvc/SyXDhIFEAFNyo2adxXRmcfQGtm08b9TrXy3mhEQS0
         nttcKWsuIFjOQKVaZuqudSSCqYKZuBdV3ZhrK7uVo4yO/CAAJ7CZnH6tVwwt84t+P15r
         IdGQPAlttl8JhIXJNjs6DAdO3c40p2N5TjELPhywimltCIjKLngn/RyVCSeuXJxtJcYJ
         wzOLlKLmBTBlmMOeEMH7gdKIttBAyIRWukIAOSPbyDkktIia0zgxhZ6mcfOyAuJcZ7Mg
         TnzNT9F6EIevyNnqpO5tzoT9Ow1u6z4xdoPIGL4MtzoLc01eOAtftlnKPpWzdBWwB3JV
         MFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772413865; x=1773018665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLzx4QloOR7w220ELbFdJo9+YB2Xr38O5JizyVmv14A=;
        b=WaszIfKowKYAPT69VeEF0bVb+6SISbshNzaonvIOD/LYbYIVfv5Mpht16pdDweOvjm
         7He06aNCT1jZFCRa3Z+qbRPDukZkE5iLQsDPcbOHCKNANGzrlab7KQp+xuIWeKJ5t65w
         b/0IHgENxr/BMbg+RFrMLAZQ5D8KuXmr1AQvcyY/AIJ8xelDWI7W/j5mdKJhfB0hxs5z
         auw3RRf/N7Y2BOLaDSqc0NSpTFX6vyDNkFp2Y8dMjy83rKiKGEojhvXJoObaH4qqZOJy
         KH41mZxebdhVJVAY65o6J+Pdwi7XddGmaaXaBJM6iAwRDZUfM4+91kYX7YRwJJLdo4ii
         TTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUikR8sCBHHC5filQGOIqzleMHj4hoqj+LEHwpzvnD92icr092JhP1MJw7wTGdwIYMhL+VXUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpIbzpx5sRREiVRb1qh3wwWx1I79vulY8TkT8Y5J5AefriXos
	m4nU0PltQwIWcyYSFTeDbTQ+0JJVB6RZjSSwu+7vqFYcbbmFvsEnv4du/PTMlE+4wH8=
X-Gm-Gg: ATEYQzyxCPNBPfY6i08G7N197fB2VpMAuVRn0ticWTkQyc+ffj+X8FpqGMct9pGF3yc
	uX9pKp0zN8JnL7rzMudOJlsBjD/UbavHYJ1WCEHb/F/l1MuE5wY8UbOrwtE4Drg37s0kwUa2VXb
	R8x/s8dmftAf/UvtBJfR7g0EJvR0UkFPbehIDRJTINsSMGy2SjnrADuD8OZDeuViKI6xEtoEZGD
	8qR4yzoCzsP8ivhQ26s/Vej5iQyDE6yH6fZGiBMdCDIjnc+xofNLh3XiSnJv8+NHbMsslvTOtXI
	zweaJZulauUUwI3waQ4Do2SJqRbh083wLSX5rVf3o+UF78qdw7HcJUiKaRjPLydmM4ik1aaSuun
	QJ/b9ulWqqCDAC5D4NvR4WZHDSI/Z1xV0mfpFer+MoOPurixpnggtznFHSj0IJctPuqFBDJ9p6t
	AGgurlIuHCsWOmDNKUuizauYZ1xnA1lg/xPiqEQAy7heZ5Dsix4jFutUUD5WzPZp0Y
X-Received: by 2002:a05:7022:4381:b0:11e:528:4185 with SMTP id a92af1059eb24-1278fc568a2mr4166249c88.38.1772413864497;
        Sun, 01 Mar 2026 17:11:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43c12sm12792111c88.14.2026.03.01.17.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 17:11:04 -0800 (PST)
Date: Sun, 1 Mar 2026 17:11:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Mirko Lindner
 <mlindner@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] net: ethernet: marvell: skge: remove incorrect
 conflicting PCI ID
Message-ID: <20260301171101.16d07cbe@phoenix.local>
In-Reply-To: <20260206071724.15268-1-enelsonmoore@gmail.com>
References: <20260206071724.15268-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222499-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: DF1331D23AD
X-Rspamd-Action: no action

On Thu,  5 Feb 2026 23:17:14 -0800
Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:

> The ID 1186:4302 is matched by both r8169 and skge. The same device ID
> should not be in more than one driver, because in that case, which
> driver is used is unpredictable. I downloaded the latest drivers for
> all hardware revisions of the D-Link DGE-530T from D-Link's website,
> and the only drivers which contain this ID are Realtek drivers.
> Therefore, remove this device ID from skge.
>=20
> In the kernel bug report which requested addition of this device ID,
> someone created a patch to add the ID to skge. Then, it was pointed
> out that this device is an "r8169 in disguise", and a patch was created
> to add it to r8169. Somehow, both of these patches got merged. See the
> link below.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D38862
> Fixes: c074304c2bcf ("add pci-id for DGE-530T")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

I was intrigued as to how this happened, and sent of AI to find out.

D-Link DGE-530T: Chipset History and Driver Confusion
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

D-Link shipped multiple hardware revisions of the DGE-530T under the
same product name and packaging, but with completely different chipsets:

  Rev A1 - Marvell 88E8003 (SysKonnect Yukon)
  Rev B1 - Marvell 88E8001 (SysKonnect Yukon)
  Rev B2 - Marvell 88E8001-LKJ1 (SysKonnect Yukon)
  Rev C1 - D-Link DLG10028C, a rebadged Realtek RTL8169

The Marvell-based revisions (A/B) used PCI ID 1186:4b01 and were
driven by skge (the SysKonnect/Marvell Yukon driver, originally
sk98lin). The Realtek-based Rev C1 used PCI ID 1186:4302 and
required the r8169 driver.

So the PCI device IDs were actually different across chipset families,
but they shared the same D-Link vendor ID (1186) and identical product
branding.

Driver history and the VPD problem
-----------------------------------

The original SysKonnect vendor driver (sk98lin) had the D-Link
1186:4c00 entry commented out in its PCI table:

  /* DLink card does not have valid VPD so this driver gags
   * { PCI_VENDOR_ID_DLINK, 0x4c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
   */

The issue wasn't really that the card had bad VPD =E2=80=94 D-Link simply
didn't populate the Vital Product Data fields the way SysKonnect's
own boards did, and sk98lin's probe path depended on reading VPD
during initialization. When skge was written as a clean replacement
for sk98lin, it had no VPD dependency, so the D-Link entry (1186:4c00)
went in unconditionally. The 1186:4b01 entry for Rev B was added
later as users reported it.

When the Rev C1 appeared with a Realtek RTL8169 chip, the 1186:4302
PCI ID was added to both the r8169 driver (by Lennart Sorensen in
commit 93a3aa25933461d, July 2011) and to skge's PCI table. This
meant both modules would match the Rev C1 card, even though skge
could never actually drive it =E2=80=94 the probe would bail out when it
read the chip ID and got something that wasn't a Yukon. The result
was that lspci would report "Kernel modules: skge, r8169" for the
C1, which was harmless but untidy.

The bogus 1186:4302 entry has since been removed from skge upstream,
though it's unlikely any DGE-530T cards of any revision still exist
in the wild at this point.

The chipset swap was widely regarded as a cost-cutting move that
degraded performance significantly. The Marvell Yukon was well
respected; the Realtek 8169 was not. Many users and integrators
stopped recommending the DGE-530T after the C1 appeared.

