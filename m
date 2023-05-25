Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC9710E06
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjEYOLk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjEYOLi (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 10:11:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB06186;
        Thu, 25 May 2023 07:11:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E323521CB5;
        Thu, 25 May 2023 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685023895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LMsDV6T2jCcjcJj5VyXqb2kAeEnI/lDz50c0BzZL3V4=;
        b=J2djAVASI/Bf6kURBwuN6TTFCfuPq8Gd7sjwT/n1eoPwgRcHtgZyy3YC5xZ4SbcPMJAGlb
        y032Au0Jv3m4osldNPB8CBHdobQpSP9NJMPAladVxS/1R7JSVq1k+LOC6krw7Tt+d5L45U
        xEU21lSuBZVgPxBDWVCodsi4CE0vU/4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B75C2134B2;
        Thu, 25 May 2023 14:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bz2gK5dsb2RVZQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 25 May 2023 14:11:35 +0000
Date:   Thu, 25 May 2023 16:11:34 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH V3] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <sqsb7wcvxjfd3nbohhpbjihbr4armrh5sr6vu5pxci62ga7for@6om7ayuncxnc>
References: <20230525043518.831721-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hyhnghupqumzotmb"
Content-Disposition: inline
In-Reply-To: <20230525043518.831721-1-ming.lei@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--hyhnghupqumzotmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 12:35:18PM +0800, Ming Lei <ming.lei@redhat.com> wr=
ote:
> It is less a problem if the cgroup to be destroyed also has other
> controllers like memory that will call cgroup_rstat_flush() which will
> clean up the reference count. If block is the only controller that uses
> rstat, these offline blkcg and blkgs may never be freed leaking more
> and more memory over time.

On v2, io implies memory too.
Do you observe the leak on the v2 system too?

(Beware that (not only) dirty pages would pin offlined memcg, so the
actual mem_cgroup_css_release and cgroup_rstat_flush would be further
delayed.)

> To prevent this potential memory leak:
>=20
> - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
> can be added
>=20
> - add global blkg_stat_lock for covering concurrent parent blkg stat
> update

It's bit unfortunate yet another lock is added :-/

IIUC, even Waiman's patch (flush in blkcg_destroy_blkcfs) would need
synchronization for different CPU replicas flushes in
blkcg_iostat_update, right?

> - don't grab bio->bi_blkg reference when adding the stats into blkcg's
> per-cpu stat list since all stats are guaranteed to be consumed before
> releasing blkg instance, and grabbing blkg reference for stats was the
> most fragile part of original patch


At one moment, the lhead -> blkcg_gq reference seemed alright to me and
consequently blkcg_gq -> blkcg is the one that looks reversed (forming
the cycle). But changing its direction would be much more fundamental
change, it'd need also kind of blkcg_gq reparenting -- similarly to
memcg.


Thanks,
Michal

--hyhnghupqumzotmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZG9shwAKCRAkDQmsBEOq
ucuTAP0a8JcBs2PoQvq0qKyo0/MnzWO1v2gQ5TcBEw6Ne3L7CgD+OFG+18/XCgsa
XfLIW1CRCnJ+phqelsySvrMcvUNsNAM=
=la8T
-----END PGP SIGNATURE-----

--hyhnghupqumzotmb--
