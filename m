Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D627823B3
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 08:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHUG2v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 02:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjHUG2u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 02:28:50 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E9A2
        for <stable@vger.kernel.org>; Sun, 20 Aug 2023 23:28:47 -0700 (PDT)
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
        by mail.avm.de (Postfix) with ESMTP;
        Mon, 21 Aug 2023 08:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1692599324; bh=KNR99+O0uR/XieId5VErLIBpmCA9SVzJG7G/6ns31qQ=;
        h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
        b=xEQo9FiwLMtJKleG2zIk7HjbcyH8BiFU2CPWUANAajNbcVBxn0Y0pRb7b6hl7k2yb
         sNd5O1l3kUFVQFoJ0+psj2Rbh0YbLHmsQPm3HtR1dgLRnXpUnPqLnLMZw67RzHU/C9
         D3HIpSeZP6QfXS3ohIrA6Z3jIl+qKmaS6h3OmmG0=
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <2023081752-giddily-anytime-237e@gregkh>
References: <2023081752-giddily-anytime-237e@gregkh>,
        <OF964B0E9A.174E142D-ONC1258A0E.0032FEAA-C1258A0E.00337FA7@avm.de>
Subject: Re: proc_lseek backport request
From:   t.martitz@avm.de
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>
Date:   Mon, 21 Aug 2023 08:28:44 +0200
Message-ID: <OF38330399.317AA8E2-ONC1258A12.00239743-C1258A12.00239746@avm.de>
X-Mailer: Lotus Domino Web Server Release 12.0.2FP2 July 12, 2023
X-MIMETrack: Serialize by http on ANIS1/AVM(Release 12.0.2FP2|July 12, 2023) at
 21.08.2023 08:28:44,
        Serialize complete at 21.08.2023 08:28:44,
        Serialize by Router on ANIS1/AVM(Release 12.0.2FP2|July 12, 2023) at
 21.08.2023 08:28:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 149429::1692599323-58FDFDF9-74CC2ACA/0/0
X-purgate-type: clean
X-purgate-size: 4979
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello,

(posting again as plain text, excuse me if you already
received the malformed HTML mail.)

-----"Greg KH" <gregkh@linuxfoundation.org> schrieb: -----


>An: t.martitz@avm.de
>Von: "Greg KH" <gregkh@linuxfoundation.org>
>Datum: 17.08.2023 16:43
>Kopie: stable@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>
>Betreff: Re: proc=5Flseek backport request
>
>On Thu, Aug 17, 2023 at 11:22:30AM +0200, t.martitz@avm.de wrote:
>> Dear stable team,
>>
>> I'm asking that
>>
>> commit 3f61631d47f1 ("take care to handle NULL ->proc=5Flseek()")
>>
>> gets backported to the stable and LTS kernels down to 5.10.
>>
>> Background:
>> We are in the process of upgrading our kernels. One target kernel
>> is based on 5.15 LTS.
>>
>> Here we found that, if proc file drivers do not implement
>proc=5Flseek,
>> user space crashes easily, because various library routines
>internally
>> perform lseek(2). The crash happens in proc=5Freg=5Fllseek, where it
>> wants to jump to a NULL pointer.
>>
>> We could, arguably, fix these drivers to use ".proc=5Flseek =3D
>no=5Fllseek".
>> But this doesn't seem like a worthwhile path forward, considering
>that
>> latest Linux kernels (including 6.1 LTS) allow proc=5Flseek =3D=3D NULL
>again
>> and *remove* no=5Flseek. Essentially, on HEAD, it's best practice to
>leave
>> proc=5Flseek =3D=3D NULL.
>> Therefore, I ask that the above procfs fix gets backported so that
>our
>> drivers can work across all kernel versions, including latest 6.x.
>
>For obvious technical, and legal reasons, we can not take kernel
>changes
>only for out-of-tree kernel modules, you know this :)
>
>So sorry, no, we should not backport this change because as-is, all
>in-tree code works just fine, right?

The kernel is constantly being changed to support out-of-tree modules,
be it kbuild changes or new EXPORT=5FSYMBOLs (all in-tree modules
can use EXPORT=5FSYMBOL=5FGPLs right?).

Granted, such changes are typically not backported to stable (probably,
haven't checked). I had hoped that you'd be less strict if we talk about a
patch that's already in mainline.

But well, we'll cherry-pick this in our tree then and move on.
I won't argue about this particular patch further.


>
>Attempting to keep kernel code outside of the kernel tree is, on
>purpose, very expensive in time and resources. The very simple way
>to
>solve this is to get your drivers merged properly into the mainline
>kernel tree.
>
>Have you submitted your drivers and had them rejected?

Most drivers affected by the above patch are delivered to us by
chip vendors that we cannot post publicly without their consent. It's
also not our job to get their crappy code (and it's a lot of that!) to a
state that meets your quality standards. We can and do ask for mainline
drivers but our influence is limited.

Also, would driver code for chips that aren't publicly available any useful=
 for you?

There is also some in-house code affected but that "drivers" don't usually
drive hardware but simply provide F!OS-specific proc interfaces (F!OS
is the name of the firmware that runs on our devices). These are just
software, often device or vendor specific, and not suitable for the wider
kernel community. Also we don't have the resources to get our code
top-notch for potential mainline inclusion (although it's usually better
than the vendor code we receive).

On the positive side, we do realize that mainlining things can be a net win=
 for us
long term and we have started an internal process that allows us to selecti=
vely
mainline portions of our in-house code, but it's limited by resources and
therefore a slow process. See [1] for example.

[1] https://lore.kernel.org/all/20230619071444.14625-1-jnixdorf-oss@avm.de/

>
>Have you taken advantage of the projects that are willing to take
>out-of-tree drivers and get them merged upstream properly for free?

I don't know about any such project. Interesting to hear they exist! Who ar=
e they?

>
>Is there anything else preventing your code from being accepted into
>the
>upstream kernel tree that we can help with?


Thanks for the offer. I don't think you can help much. We need to get more
resources internally for mainlining but we can barely keep up with maintain=
ing
our code base for our devices currently.

Best regards,
Thomas Martitz


>
>thanks,
>
>greg k-h
>
>
>
>>
>> I checked that this commit applies and works as expected on a board
>that
>> runs Linux 5.15, and the observed crash goes away.
>>
>> Furthermore, I investigated that the fix applies to older LTS
>kernels, down
>> to 5.10. The lseek(2) path uses vfs=5Fllseek() which checks for
>FMODE=5FLSEEK. This
>> has been like that forever since the initial git import. However,
>5.4 LTS and
>> older kernels do not have "struct proc=5Fops".
>>
>> Thank you in advance.
>>
>> Best regards,
>> Thomas Martitz
>
