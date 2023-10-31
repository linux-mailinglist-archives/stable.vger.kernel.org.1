Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6F7DD04E
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 16:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbjJaPQt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344861AbjJaPPt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 11:15:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E810FE
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 08:14:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE4BB21A7E;
        Tue, 31 Oct 2023 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698765293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttwVFVyo3uFcwo/0WVgo/2vJ4jsEZKASnDSRUSiQD38=;
        b=j2VRAVrm2/MRlBTM5ovdPWcEFF5KSzA7Aysp/sClA13dGjkemDvIW/FJJcgaJ+xbEJSYVo
        Vwy3OacRqXX71+IYAuXdwK+fg0M7kGR/YAzcQXy/nVwmjaztGLAfg+Mhlcvq1a+CO9odHX
        tvi/8rxg4tG3RRWiaXzS6P0rWWISzAk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F2781391B;
        Tue, 31 Oct 2023 15:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IjOEJO0ZQWU5LAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 31 Oct 2023 15:14:53 +0000
Date:   Tue, 31 Oct 2023 16:14:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        lstoakes@gmail.com, stable@vger.kernel.org, yikebaer61@gmail.com
Subject: Re: FAILED: patch "[PATCH] mm/mempolicy: fix
 set_mempolicy_home_node() previous VMA" failed to apply to 6.1-stable tree
Message-ID: <qrlttjzrepbqo6tpd2wdiirdgsuum3n5ygqcehp6kuwhokvf2a@ce564jcma56d>
References: <2023102704-surrogate-dole-2888@gregkh>
 <20231031135111.y3awm4b3jvbybpca@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135111.y3awm4b3jvbybpca@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue 31-10-23 09:51:11, Liam R. Howlett wrote:
> 
> Added Michal to the Cc as I'm referencing his patch below.
> 
> * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [231027 08:14]:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 51f625377561e5b167da2db5aafb7ee268f691c5
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102704-surrogate-dole-2888@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > 
> > Possible dependencies:
> 
> Can we add this patch to the dependency list?  It will allow my patch to
> be applied cleanly, and looks like it is close to a valid backport
> itself.
> 
> e976936cfc66 ("mm/mempolicy: do not duplicate policy if it is not
> applicable for set_mempolicy_home_node")
> 
> If you don't agree, I can rework my patch to work without it.

No objection from me. The patch is really straightforward and shouldn't
pose an additional risk
-- 
Michal Hocko
SUSE Labs
