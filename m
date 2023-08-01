Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9E76AA28
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjHAHmE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 03:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAHmE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 03:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5111AE4
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 00:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CABDD614B0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D465FC433C7;
        Tue,  1 Aug 2023 07:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690875722;
        bh=jRSmWh+NhrYAQduCkQ8Q34Std4WJOLn1l6HSknsTOpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eafMNsH/wC11QVsETZ9Gj3AdWNRaEPp8jrjCp2AUB3iaxnlaMiCbIezpMPdCk4f3+
         N3BIWGIQfZ3dqUWrj0NRbuvGTM66a5jtGqtomhfhhKOOYAYT5a0Tx/KTj23pT4VnZK
         wVV7i5jN1gyOOaCcj0XnppkqKWjOCgRTOozzrYsU=
Date:   Tue, 1 Aug 2023 09:41:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.10.y] selftests: mptcp: depend on SYN_COOKIES
Message-ID: <2023080153-botch-slapping-ebf5@gregkh>
References: <2023072148-curry-reboot-ef1c@gregkh>
 <20230726165547.1843478-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726165547.1843478-1-matthieu.baerts@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 26, 2023 at 06:55:47PM +0200, Matthieu Baerts wrote:
> commit 6c8880fcaa5c45355179b759c1d11737775e31fc upstream.
> 
> MPTCP selftests are using TCP SYN Cookies for quite a while now, since
> v5.9.
> 
> Some CIs don't have this config option enabled and this is causing
> issues in the tests:
> 
>   # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     (duration   167ms) sysctl: cannot stat /proc/sys/net/ipv4/tcp_syncookies: No such file or directory
>   # [ OK ]./mptcp_connect.sh: line 554: [: -eq: unary operator expected
> 
> There is no impact in the results but the test is not doing what it is
> supposed to do.
> 
> Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Backport notes:
>   - We don't have kconfig that have been added later, that's normal.
>   - Only added the new kconfig dep then.
> ---
>  tools/testing/selftests/net/mptcp/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 1a4c11a444d9..8867c40258b5 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -6,3 +6,4 @@ CONFIG_INET_DIAG=m
>  CONFIG_INET_MPTCP_DIAG=m
>  CONFIG_VETH=y
>  CONFIG_NET_SCH_NETEM=m
> +CONFIG_SYN_COOKIES=y
> -- 
> 2.40.1
> 

All now queued up, thanks.

greg k-h
