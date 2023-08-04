Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B2676FE7B
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjHDK3i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjHDK3V (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 06:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1296949CC
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 03:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A4461F11
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 10:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CA0C433C9;
        Fri,  4 Aug 2023 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691144958;
        bh=tAcngKZrxhxSkgFjpM/7QiSYxDpEVJ96Id1+CLCutlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdcUkS+CUccu5lTWRpAywtDH/5W5PgVsK/VKJj6MxK+/0ywa7EMUuAXfGJOBm9+aw
         C4vW3iyyXlEgq8/8v8Q7eRPLGirPHiZlq6dWJFhPjCCdIv4bvQeUCXZovrMSMTZ+dr
         3cV8bxoYyzgxefvGuHlHBG+wN8nsFMpluX/yEMp8=
Date:   Fri, 4 Aug 2023 12:29:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brennan Lamoreaux <blamoreaux@vmware.com>
Cc:     stable@vger.kernel.org, akaher@vmware.com, amakhalov@vmware.com,
        vsirnapalli@vmware.com, ankitja@vmware.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4.19.y] drivers core: Use sysfs_emit and sysfs_emit_at
 for show(device *...) functions
Message-ID: <2023080459-visitor-fleshy-7e05@gregkh>
References: <86FA1210-9388-4376-B4A3-5F150E33B19F@vmware.com>
 <20230801213044.68581-1-blamoreaux@vmware.com>
 <2023080459-sprint-dreamless-eb79@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080459-sprint-dreamless-eb79@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 04, 2023 at 12:22:09PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 01, 2023 at 02:30:44PM -0700, Brennan Lamoreaux wrote:
> > From: Joe Perches <joe@perches.com>
> > 
> > commit aa838896d87af561a33ecefea1caa4c15a68bc47 upstream
> > 
> > Convert the various sprintf fmaily calls in sysfs device show functions
> > to sysfs_emit and sysfs_emit_at for PAGE_SIZE buffer safety.
> > 
> > Done with:
> > 
> > $ spatch -sp-file sysfs_emit_dev.cocci --in-place --max-width=80 .
> > 
> > And cocci script:
> > 
> > $ cat sysfs_emit_dev.cocci
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	<...
> > 	return
> > -	sprintf(buf,
> > +	sysfs_emit(buf,
> > 	...);
> > 	...>
> > }
> > 
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	<...
> > 	return
> > -	snprintf(buf, PAGE_SIZE,
> > +	sysfs_emit(buf,
> > 	...);
> > 	...>
> > }
> > 
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	<...
> > 	return
> > -	scnprintf(buf, PAGE_SIZE,
> > +	sysfs_emit(buf,
> > 	...);
> > 	...>
> > }
> > 
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > expression chr;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	<...
> > 	return
> > -	strcpy(buf, chr);
> > +	sysfs_emit(buf, chr);
> > 	...>
> > }
> > 
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > identifier len;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	<...
> > 	len =
> > -	sprintf(buf,
> > +	sysfs_emit(buf,
> > 	...);
> > 	...>
> > 	return len;
> > }
> > 
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > identifier len;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	<...
> > 	len =
> > -	snprintf(buf, PAGE_SIZE,
> > +	sysfs_emit(buf,
> > 	...);
> > 	...>
> > 	return len;
> > }
> > 
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > identifier len;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	<...
> > 	len =
> > -	scnprintf(buf, PAGE_SIZE,
> > +	sysfs_emit(buf,
> > 	...);
> > 	...>
> > 	return len;
> > }
> > 
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > identifier len;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	<...
> > -	len += scnprintf(buf + len, PAGE_SIZE - len,
> > +	len += sysfs_emit_at(buf, len,
> > 	...);
> > 	...>
> > 	return len;
> > }
> > 
> > @@
> > identifier d_show;
> > identifier dev, attr, buf;
> > expression chr;
> > @@
> > 
> > ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> > 	...
> > -	strcpy(buf, chr);
> > -	return strlen(buf);
> > +	return sysfs_emit(buf, chr);
> > }
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > Link: https://lore.kernel.org/r/3d033c33056d88bbe34d4ddb62afd05ee166ab9a.1600285923.git.joe@perches.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > [ Brennan : Regenerated for 4.19 to fix CVE-2022-20166 ]
> > Signed-off-by: Brennan Lamoreaux <blamoreaux@vmware.com>
> 
> Thanks, now queued up.

Nope, now dropped, this didn't even build.  How did you test this thing?

{sigh}

greg k-h
