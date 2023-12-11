Return-Path: <stable+bounces-6379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8CA80DFC5
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 00:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C586D2825B7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196656B7C;
	Mon, 11 Dec 2023 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leolam.fr header.i=@leolam.fr header.b="W1wgWar/"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 94813 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 15:59:45 PST
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61C9B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 15:59:45 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SpzHz2KD4zMpvcJ;
	Mon, 11 Dec 2023 23:59:43 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SpzHy2Z3WzMppt7;
	Tue, 12 Dec 2023 00:59:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leolam.fr;
	s=20210220; t=1702339183;
	bh=jjW/zrs1aRaIEZRRpD4EKlCD5lEQQcr71+43lFS39WE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=W1wgWar/uI016qC3nE+kaWogpLjWpSRm92A+ha7lotLtyWrTpmOU6w+QS3/LY/yTI
	 4vo6U/v9KUea3ETTGploajspZh/qTYHg/6snLDqSbwr9zyE8eBO6hTcVpHnrYEwPRt
	 vaI+jNLy5oQyHj5I093WSsQohd7bbCA3Wu0k6t+M=
Message-ID: <c676ae54d9dddd025a5416ddaa464727a2ec52d2.camel@leolam.fr>
Subject: Re: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi
 (6.6.x)
From: =?ISO-8859-1?Q?L=E9o?= Lam <leo@leolam.fr>
To: Philip =?ISO-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: stable@vger.kernel.org, johannes.berg@intel.com, Greg KH
	 <gregkh@linuxfoundation.org>
In-Reply-To: <c4e5775a-3672-4b1c-8654-ae42f928d5cd@manjaro.org>
References: <20231210213930.61378-1-leo@leolam.fr>
	 <2023121135-unwilling-exception-0bcc@gregkh>
	 <718120b0a3455e920e6b7d78619cf188651cb1b6.camel@leolam.fr>
	 <c4e5775a-3672-4b1c-8654-ae42f928d5cd@manjaro.org>
Autocrypt: addr=leo@leolam.fr; prefer-encrypt=mutual;
 keydata=mQINBFUYZ/EBEACaLCqWye+E2YgVLQwzMcWjZ0sAnQPguW4jEqPWyy16S3clj5h6AMSjLSbhIYYNEomo71DkrSg2IsmYN17WjrAfBr5XsDakqz+uLHzGxdKGr1ZP8vGISf4cecLBvVzsbv+fGvcXyZ+tUrIC+v+E/TKUuE67DhfUuB33tu+9zDumagQAyihF++kxkMx36TLzgSxERMK7i6S3YkogNFRtioW5BjIkEB5NXId8mxCL9B16FtAn2eCsvP0GwzlFABqGrkpFHPKiMDlQHeKrvEkvQmDEZYzIi7esWPIR5j6ya/24Z9q6q9SlxapY2Eh474O3jmoQdIKLnw19kr04jCrVKEKEdHKGU+FPAzhWFZDJLoAb3ISrqNWr3qWzuQZX0cQaWt2FpOcCek6Hwq8n1MalrX3FQ3X51w3osw1r19UqiaW/iB+JaSPXKCIZWzAeidjLsg5v5mHBVoRh4Lv77V7h05x9NjuO739PW6h9yCGDYG9ac8Gcolu/8zctm+9JJSsjFoJzFER5QkrevOKCC01Eub0mInkFTo6N1491eqy6LPJdTlwUFsutH7qjXPdtboTc1blbdoGSV9C6Oa5q3zkxqnGKbmvE9wu4i0mQZfTZYcTQX5oHof3BvASBDP5AOmPUil/LFLhEbWQ8xsoBwkIvwN/x7Xx5vcuECcJsk6D7xaaIWQARAQABtBhMw6lvIExhbSA8bGVvQGxlb2xhbS5mcj6JAjkEEwECACMFAlUYZ/ECGwMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRAN8w+QgQAHQQMcD/9m8Kz0Sou4bvmrsqdsl02qSpcj5OQtEwYuueJ6z6NBCwyqlMw2BqvCzuj0eWEn1Py6OUBtqsKEu+/6KGNAincupYcxJnGO2gMRWcE6ExiCDpUReKB6/YXELV0bfFKmzcWHWpzqK5Bwn8AONa5R+1PlykKDGBsN1IG+tFyR3dupy
	
 sAIhizyOD6L1sNM8Jj6Kex6bEBnoWiuzPj3sSizdE4pL5XwLV40izgzVrme/ikucn/GtoY0fwbXDAdlzGp8LCD13Q2XlmIyVMMaO4DJMS6qtXCh0ThxKoqUTogROmkBP/c1l+i7LON3JxOW2oxqPt8jCoau8ATMbyz6Bvq6AjRZcsU5zzyVnHv8yI5JVXoVYB8hvut4+v4zuqTa3eonsQU8nmnPOZCPxyHJfp/HsurvL2ChzfadcF2sd5LcS6cXK52/csbyUT0PtcAHFyE9kd095jTAVpKByGNORje5Y7s3iYA13FQxJZAQAePgoNGFusAPLdi7Gv7/yeK/+P2W0pZrQjdGYS2OnN8mWjxOsFE6gLdqpIuRIXgl0rb9QZdlQluN/J+TTWaYJXhnMCftLSK56bubX90m6LRykcE7AJZpq2UdaVxIWoTKL9AqIE7qTEWFr6dPRFgqcLDMPvTG5UH6Z29JtIDxj4e5yHEh9P7fyT8RQHC9Snmf6LjpYS2t/rkCDQRVGGfxARAArVO/z5zUMRs/ejGOkjapGrSyRWrrzwA3enFqwTvE29XFIxnn3X0kKk7oHtoc2pNgwRTMQmJ+3fzkVmi801NwV9O16eHjFtNG4LbTke9yoH/0u33ge4rV5qywgzEwxlI4UutV7TbVkzRAi9ymNk3b/f9O2KexinHJEXFlQu1xSxfHDClrLMuj162WA53GhD3mTaXXQrL2+Lm/JKLgLFSsl3cBT0mpPHHWWG5aqhp8QAXtzdmCFZ4fAH+KGJwbIbDeY7xU0CrSRREGyVvh1lyOVOVbVEpWHnYaWXf833P1dkfDMZnAq5cURY+Js+0fZJMI3x3hLmnRAgjMa6DKeeKrXN4twNff8r+7S1mR4iOm6ozYZB0LvnWx5yHZJALNTsvv0fAlyO8eh4ZtuHuwM6mCslhq0En53TekJtG8FHt2CGZMhmO3QM1uw8OzJ4o9JUNNnQrqMMpXgLcUFuheClcXJP
	
 hJyKgB8X4OR6qiZvUtB4B2D/xW4CYBl40mqgMk+flsUqRlCYoTKQpxcroE5keE+Rjo+qz8WDzWmdAne8zCUw8c+vH4uhnR7R7X9tb/r6ZhXfpe+tSvP982CFfSvjU0rqvo2t7l6RjTov2bG2ipatTdwIxT62QbR+EaU/fJjCw9gW8Ne4IrLk26mJmXVkLYkCKGT6FW61f+v8ki+m16XpsAEQEAAYkCHwQYAQIACQUCVRhn8QIbDAAKCRAN8w+QgQAHQeheD/9CUnhZ92O7QNc7zUuumvTkXAdXBQS2j7ZOPLzmJ0OU4MUIjuC/ucXc+tH+qpYW+jLtWQWqTIBoRyv0qvFp71sQ0KcjUV8GerU8pe8medJvV8BH26ENkEp7BZ1crKqIF8Vi9HD4YgivnGt+Xh+6BC2p4GoiJFVa69rT38hSGxCl7p8n/2XWNWUer5jXFEkDH9F6P+lr6X0B3KQTGhn39ff8n7E2fjmEfOCAGVGmHIuFSxkhCPKN67faMdQ2wCacrSLGjpm0fcCOAIwP57N5iPbI0N1nLGuCpKBr7s9gc+lIqd6/FO3YWa9yru8BcZ+X6qjPQE1ro6mF8a0BGfVKPsn5Pj554JPQ1KMYws/uR12JxRmkE49qO68UfJm9VYH9lo86ObcMDPU/bo6R9mL4hXg+YiQhxwOn1vuiJSei9NLqiJDKvKtocuabZwhJsuE2lpwJ7ZjnsnZ2ArwjOdH1d7wsdeAV5UQrO3T2TTfrV6KIgr0CG+rNQ53bb/V2pRvyNRNuVVjA76Ymmw970B0Zb8EmhNCEJNB58STDXkdUM3saFApOu5r6pd1+WaKc4m27IXIM+0ugaQhgtm27k0dUcl7PkyXCitbczso511KXD33oUJbEbu2EwKEkDdOCxshZ9hTeGl60M0PQl1JdQteiq63vwifjzvB2h5iK0fcegSEibA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 23:59:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.50.2 
X-Infomaniak-Routing: alpha

On Tue, 2023-12-12 at 06:15 +0700, Philip M=C3=BCller wrote:
> On 12.12.23 05:57, L=C3=A9o Lam wrote:
> > On Mon, 2023-12-11 at 07:47 +0100, Greg KH wrote:
> > > On Sun, Dec 10, 2023 at 09:39:30PM +0000, L=C3=A9o Lam wrote:
> > > > Commit 4a7e92551618f3737b305f62451353ee05662f57 ("wifi: cfg80211: f=
ix
> > > > CQM for non-range use" on 6.6.x) causes nl80211_set_cqm_rssi not to
> > > > release the wdev lock in some situations.
> > > >=20
> > > > Of course, the ensuing deadlock causes userland network managers to
> > > > break pretty badly, and on typical systems this also causes lockups=
 on
> > > > on suspend, poweroff and reboot. See [1], [2], [3] for example repo=
rts.
> > > >=20
> > > > The upstream commit, 7e7efdda6adb385fbdfd6f819d76bc68c923c394
> > > > ("wifi: cfg80211: fix CQM for non-range use"), does not trigger thi=
s
> > > > issue because the wdev lock does not exist there.
> > > >=20
> > > > Fix the deadlock by releasing the lock before returning.
> > > >=20
> > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218247
> > > > [2] https://bbs.archlinux.org/viewtopic.php?id=3D290976
> > > > [3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/
> > > >=20
> > > > Fixes: 4a7e92551618 ("wifi: cfg80211: fix CQM for non-range use")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: L=C3=A9o Lam <leo@leolam.fr>
> > > > ---
> > > >   net/wireless/nl80211.c | 18 ++++++++++++------
> > > >   1 file changed, 12 insertions(+), 6 deletions(-)
> > >=20
> >=20
> > Apologies for the slow reply - been dealing with some eye soreness. :(
> >=20
> > First of all, thank you for taking the time to review this and for
> > reverting the broken commit so quickly as it seems quite a few users
> > were hitting this.
> >=20
> > > So this is only for the 6.6.y tree?  If so, you should at least cc: t=
he
> > > other wireless developers involved in the original fix, right?
> > >=20
> > You're right. Sorry I forgot to cc: johannes.berg@intel.com; though jus=
t
> > to clarify, there is nothing wrong with their commit per se; the issue
> > comes from how it was backported without 076fc8775daf ("wifi: cfg80211:
> > remove wdev mutex").
> >=20
> > > And what commit actually fixed this issue upstream, why not take that
> > > instead?
> > >=20
> >=20
> > As far as I understand, this was never an issue upstream because
> > 076fc8775daf ("wifi: cfg80211: remove wdev mutex") was committed in
> > August, *before* commit 7e7efdda6adb ("wifi: cfg80211: fix CQM for non-
> > range use") added the early returns in late November. This only became
> > an issue on the 6.1.x and 6.6.x trees because the CQM fix commit thxwas
> > applied without first applying the "remove wdev mutex" as well.
> >=20
> > I did consider taking 076fc8775daf (i.e. removing the wdev mutex) and
> > applying it to the 6.6.x tree but that diff is much bigger than 100
> > lines long and I thought it would be simpler and safer to just fix the
> > buggy error handling. Especially for a newcomer who isn't very familiar
> > with the development process...
> >=20
> >=20
>=20
> Hi Leo,
>=20
> thx for the patch. At least some users on my end can say it fixed the=20
> issue for them. Also Johannes checked your patch by now:=20
> https://lore.kernel.org/stable/DM4PR11MB5359FE14974D50E0D48C2D02E98FA@DM4=
PR11MB5359.namprd11.prod.outlook.com/
>=20
> So your patch can be applied via a patch series by including Johannes=20
> Berg's patch as well. Addressing all error paths works too in the end ;)
>=20

Sorry if this is a newbie question, but just to confirm: do we really
want a patch series with:

1. Johannes Berg's original patch (7e7efdda6adb);
2. my error handling patch

...instead of an adjusted version of 7e7efdda6adb with the error
handling fixed for the older trees?

I thought each patch in a series was supposed to produce a working
kernel (to make bisects easier among other things).

--=20
Thanks,
Leo


