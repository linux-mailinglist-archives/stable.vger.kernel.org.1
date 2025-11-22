Return-Path: <stable+bounces-196591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F8C7C96E
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 08:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908964E33DF
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 07:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3E92D9792;
	Sat, 22 Nov 2025 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="dAHlYLJg"
X-Original-To: stable@vger.kernel.org
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065A1CEACB;
	Sat, 22 Nov 2025 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763796494; cv=none; b=M+bvb1NkGseG8/o0YM2yB5HmuyqAb53GzjTxZtB0G01Tlif9DVabUt4WSqZ+h+esxepVcI4VUbSW7/gXsab1ktKiWJnK2OYansQeTwQ83LauPNM1IofrWoeFDj94LnVehnAsXYgzZSwPs5f6JK8d9NWOzKTk65TChcozyEcFFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763796494; c=relaxed/simple;
	bh=ZiLM535fdW0mj5f4j73tf3z6TcZbJKBNv8W+D9/B/38=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLe8Ayhat/3qOXo0BcUKLXDWPy3g4YywDlHnmNItvBfz52HqpZ9M3K2hlkYvKY3YN7QY6gZOaEJbNyJU8n6SvdsBRKSs6HNBEf6fe2jJlSA/F6PpijoKTpyPE9GrtF3iP6pxxnbD9aIZZQd2N0tzoK12slAxf9j2Vchs7CtqhL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=dAHlYLJg; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1763796484; x=1764055684;
	bh=+0Bxvudg5Br2MnIOJAd8LB0y2PKGjUacR/K9QqX9ee8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dAHlYLJgwRfRfwf8vKh7iOnOLo07xu0wkpUaqj/zOkZ44X9CC0SnNqt6OGUaJXLF8
	 2kboQNRsWNjunBJkEcWR9wuhotx4eASDb5Pp5pXblVL7yHYxhwY93l2onJqlJ1LDzj
	 MDB89hFMPxe8K81FVJJsJIsWJEJu7Q3/4Xy+iy9h3ZM0LKECkxYQtiUaWvQBBMQL9E
	 z6x0trSeTsEO2xIhNyCsJ2+Rm+9rgQWaJnk0gBEf/A3l8H2YRM8Bri8dzoWI934Fo9
	 RjJcJJG5BVbQRsV7GGahGSKTsXpLKbABMKEuZJJan/wFSmDdHtNxVn1mWNmO/EyFxv
	 ZERwy+WBFf+ag==
Date: Sat, 22 Nov 2025 07:28:00 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zizhi Wo <wozizhi@huaweicloud.com>
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
Message-ID: <8mT8aJsAQPfUnmI5mmsgbUweQAptUFDu5XqhrxPPI1DgJr7GPpbwrpQQW22Nj7fsBc5M5YKG8g0EceNQ_b3d-RPhk6RSQgGCqvaVzzWSIQw=@protonmail.com>
In-Reply-To: <2025112145-cobbler-reattach-8fb2@gregkh>
References: <zuLBWV-yhJXc0iM4l5T-O63M-kKmI2FlUSVgZl6B3WubvFEHRbBYQyhKsRcK4YyKk_iePF4STJihe7hx5H3KCU2KblG32oXwsxn9tzpTm5w=@protonmail.com> <2025112145-cobbler-reattach-8fb2@gregkh>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 6ffe701a4e5da2eb57ec9e1395c3b8ec2af3d175
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, November 21st, 2025 at 11:36, Greg Kroah-Hartman <gregkh@linuxfo=
undation.org> wrote:
> On Tue, Nov 11, 2025 at 06:38:21AM +0000, Jari Ruusu wrote:
> > Backporting upstream fixes that use guard() locking to older stable
> > branches that use old-school locking need "extra sports".
> >=20
> > Please consider dropping or fixing above mentioned patch.
>=20
> Can you provide a fixed up patch?

Below is small test program to poke /dev/console using
ioctl(VT_RESIZE) with deliberately bad parameters that
should trigger failed return status. Opening /dev/console
needs appropriate privileges.

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/vt.h>
#include <sys/ioctl.h>
int main(int argc, char **argv)
{
  int f, x, r;
  struct vt_sizes s =3D { 40000, 40000, 0 };
  if((f =3D open("/dev/console", O_RDONLY)) < 0) {
    printf("open() failed\n");
    exit(1);
  }
  for(x =3D 1; x <=3D 3; x++) {
    printf("Starting ioctl(VT_RESIZE), try %d\n", x);
    r =3D ioctl(f, VT_RESIZE, &s);
    printf(" got status %d (expected -1)\n", r);
  }
  close(f);
  exit(0);
}

On kernels that return proper failed status,
it plays like this:

| Starting ioctl(VT_RESIZE), try 1
|  got status -1 (expected -1)
| Starting ioctl(VT_RESIZE), try 2
|  got status -1 (expected -1)
| Starting ioctl(VT_RESIZE), try 3
|  got status -1 (expected -1)

On kernels that return "incorrect success" status,
it plays like this:

| Starting ioctl(VT_RESIZE), try 1
|  got status 0 (expected -1)
| Starting ioctl(VT_RESIZE), try 2
|  got status 0 (expected -1)
| Starting ioctl(VT_RESIZE), try 3
|  got status 0 (expected -1)
  =20
On kernels that return proper failed status but with
messed up console locking in error handling code path,
it locks up like this:

| Starting ioctl(VT_RESIZE), try 1
|  got status -1 (expected -1)
| Starting ioctl(VT_RESIZE), try 2

After that, the console is FUBAR.

Below is a patch for 6.12.58+ and 6.17.8+ stable branches only.
Upstream does not need this.
Signed-off-by: Jari Ruusu <jariruusu@protonmail.com>
Fixes: da7e8b382396 ("tty/vt: Add missing return value for VT_RESIZE in vt_=
ioctl()")

--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -924,8 +924,10 @@
 =09=09=09if (vc) {
 =09=09=09=09/* FIXME: review v tty lock */
 =09=09=09=09ret =3D __vc_resize(vc_cons[i].d, cc, ll, true);
-=09=09=09=09if (ret)
+=09=09=09=09if (ret) {
+=09=09=09=09=09console_unlock();
 =09=09=09=09=09return ret;
+=09=09=09=09}
 =09=09=09}
 =09=09}
 =09=09console_unlock();

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


