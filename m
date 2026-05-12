Return-Path: <stable+bounces-245571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAk6J8MoA2qw1AEAu9opvQ
	(envelope-from <stable+bounces-245571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:18:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27456520FCD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 910A4305705C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170463911CA;
	Tue, 12 May 2026 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YJ/vqPr5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093A3905EE
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591570; cv=none; b=iJ9JkiuGrnBg19/ap73EsjP6SD7yTKHoTS2PyCnfo2GK/boM35cJ7ZU2aAgghA8bGsoq4czfQHT/UB5DzEsaR3XDIg7Yt5oUTpbiEJ2+BWbsEPQxdevF0rPbIZUstzcfun0G5hgNrNCaAZtuTkiAg7eQ95+Jcdm4Tsm5BPuLhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591570; c=relaxed/simple;
	bh=rXQqx4/1m+yfikzEx/j/BeQmyl5U4JjM5vLmZPG4+aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYMXWdSpIrO+BiK686NSMlXJetzVMqHdR17kyKWDXvuv8R8Pu91+PqPm2o1lXph1eYdmqMQ9kpKOqTOIMfaNqEFvkt0k6H/U0yZ3MJTOD8S72ZKNZwT0mE5ASzWB+4HRU7F4eXelBnX272vwkzbRDWiZ1tMQ2sP/ZgUrMq6NiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YJ/vqPr5; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso1014052a91.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591568; x=1779196368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOBH16W3fNII28tVIdjvH1nqDkhp0gPMGSHYiMvOY+c=;
        b=N5A6jJnyfMh/lAts1AEmeWyBiwVm2IZgxfk8Q+zd7115qDk4urDk/SKeUdBM0qXY3q
         G8AW905ZCFCwZLDy7Roq1zWPjjNxxAgrdgHQkttKCfWFYACuJ5lJbCvCC63+IVDOwNwE
         6Vg5HilR7jVa+I+WOw5df1nXFOUIKm+7LNtP5hQpYKl+RrNycHviJcCIYPyk9yJ4fqIU
         LCYMPXmRtBKWm61DWAO1qocW86JxDVjjyStC4Tg+x5CGb/D4/LJBcdyYGLYOnkaLGV7B
         ikYL94pa1gTtlaVC12okyxk1puVXKt8vWAGOmt8GdUML7cpSfE0MlJIPkxiv+4m6NBVi
         8R5g==
X-Forwarded-Encrypted: i=1; AFNElJ8StZKgToeHKgRQS94aM26eja/bs6+RO0HE88Glt3dqlMJRAQSXoubMQoRp+DtyINf637GRVWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgm3Rw46XB6lN0UhstvMg/mEG8vu/KS5dTbYjrpjcnha2iaVjV
	lxRW907EFSRPoCNKGXdLVt24xswJwJYKM7o9WZvSL/zF8DRhIj/rizSXRr6EouMBFLw2JPNQoTq
	pBM72PSd2cKfQTVkCzgdG4fWx7tVNeFycF5y0myy0+tIbNSZUXW103iyMNpjWdPve3nxwQt5a4k
	LtEZVXRqVRReqJ71X7DkrZ/Xv8XF5qnRJglvemE6Up6AYNNEn1+Vvh0Isc5563OtqAmCBptnkPH
	WoSqt8Zr1R8bQ==
X-Gm-Gg: Acq92OEEQRe1dgPMNt/O408gyYZPiEE6dAlpFlBbOhmm4QcgbnIPyMBx8pUULwLopHa
	lll/fxTfRAt06vjewYtrT2xKT1OEiBOEDaltUAeAoWi+sbEVGB7KeuWeOTACxW+iAo84uRXa3Oq
	NYx8nvefRKfoNJF4YINdnL7sFeCvNeMoTOLoun0zS0jIqc+224/7cFiMfXollyisO84obbsgVEc
	+hqm7TN+6KsBJ/DDRNYCZtNM2xchcZQBtkGfGOGFCm3kY+ybOKXbLhkk9i6w2H/0iV+NIBPLnEx
	nMMX5hk7yZOZadR34v9s7osSh9qTZrmKjwG3TV8Kl1m9vbLNhtgb2kFelScbuvNRZD7U+Eq4Tft
	VJqtdS5ZHAK928gSm8uhu9cfXA/hj6uDvQUyqitdJepwDNLFr6BHVt5V6Ev0Lnx7FMLoUfSKp8J
	jHac1z
X-Received: by 2002:a17:90b:5344:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-368ab8638d2mr3535230a91.5.1778591568397;
        Tue, 12 May 2026 06:12:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-367d628cffasm1096065a91.4.2026.05.12.06.12.47
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 06:12:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-389e0db12cbso45036041fa.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778591566; x=1779196366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LOBH16W3fNII28tVIdjvH1nqDkhp0gPMGSHYiMvOY+c=;
        b=YJ/vqPr5zpcOygp/IMsLk1WntMzyUpFkjeMY5OmalbFGoS7jGy3zQD7+PnpaCg/r3b
         ysxSDQs2lhDoDvtyhGim4Hm3TzvcieBVv+LN8CJDU/R+XAh+Ur4iXuCl3S+ucR4PfAAx
         gFMA9xPBUbd2ZoO+/i0xbZfE1D9nvOBDisNiw=
X-Forwarded-Encrypted: i=1; AFNElJ9X6ezRsM4vfJz6OSye1nbqLD/fF3Dy+yj377CiGKI6bnxLmkKHSyeomo/dy4QHrmsMxzQZKu4=@vger.kernel.org
X-Received: by 2002:a05:6512:691:b0:5a8:950f:e92e with SMTP id 2adb3069b0e04-5a8950fe96amr7209619e87.23.1778591565951;
        Tue, 12 May 2026 06:12:45 -0700 (PDT)
X-Received: by 2002:a05:6512:691:b0:5a8:950f:e92e with SMTP id
 2adb3069b0e04-5a8950fe96amr7209595e87.23.1778591565364; Tue, 12 May 2026
 06:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
In-Reply-To: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Tue, 12 May 2026 14:12:33 +0100
X-Gm-Features: AVHnY4JaHYtrFk7C3Gzaaq5WjUZyW7kD6ZyNBupTar3Gjfb-zbg1FAqP6O5Y-2s
Message-ID: <CAOuBmub=XEwqy8LJxx7_=__OHzGuRcg-nQpF1o37L8+ZOwyesQ@mail.gmail.com>
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000084453a06519e9ef6"
X-Rspamd-Queue-Id: 27456520FCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245571-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan-bt.tan@broadcom.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Action: no action

--00000000000084453a06519e9ef6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:59=E2=80=AFAM Minh Nguyen <minhnguyen.080505@gmai=
l.com> wrote:
>
> vmci_transport_recv_connecting_server() jumps to its destroy: label
> and performs an unconditional sock_put(pending) to release the
> explicit sock_hold() taken by vmci_transport_recv_listen() before
> schedule_delayed_work().  The existing comment claimed this was safe
> because the listen handler removes pending from the pending list on
> the way out, which would prevent vsock_pending_work() from dropping
> the same reference later.
>
> That assumption breaks for a peer RST.  The default arm of the packet
> switch sets:
>
>         err =3D pkt->type =3D=3D VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EI=
NVAL;
>
> and vmci_transport_recv_listen() only calls vsock_remove_pending()
> when err < 0:
>
>         if (err < 0)
>                 vsock_remove_pending(sk, pending);
>
> For RST (err =3D=3D 0) the socket stays on the pending list, so when
> vsock_pending_work() fires it takes the is_pending=3Dtrue path and
> drops all three references itself: the pending-list reference via
> vsock_remove_pending(), then the two trailing sock_put(sk) calls.
> The unconditional sock_put() in destroy: had already dropped the
> explicit sock_hold() reference, so the second trailing sock_put(sk)
> in vsock_pending_work() is a write into the freed AF_VSOCK slab
> object.  KASAN reports a slab-use-after-free write of 4 bytes from
> refcount_warn_saturate() on the workqueue path:
>
>   BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>   Write of size 4 at addr ffff88800b1cac80 by task kworker
>   Workqueue: events vsock_pending_work
>   Call Trace:
>    refcount_warn_saturate
>    vsock_pending_work
>    process_one_work
>    worker_thread
>
> Triggering the bug requires only the ability to open a VSOCK
> connection to the target and send a RST before the listener accepts.
>
> Skip the sock_put() in destroy: when err =3D=3D 0 so it only compensates
> the cases where vmci_transport_recv_listen() actually calls
> vsock_remove_pending().  RST is the only path that reaches destroy:
> with err =3D=3D 0; every other path produces a negative value, so their
> behaviour is unchanged.
>
> Verified on lts-6.12.79 with KASAN enabled (CONFIG_KASAN_INLINE=3Dy,
> kasan_multi_shot): same trigger binary, same VM, 100 iterations:
> without this patch 52 KASAN slab-use-after-free reports fire; with
> this patch applied, 0 reports.
>
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> v2:
>   - Resubmit to netdev per Stefano Garzarella's request after v1 review.
>   - Retested the PoC with the patch applied on lts-6.12.79 with KASAN
>     enabled: 52/100 unpatched -> 0/100 patched (same trigger binary,
>     same VM, 100 iterations); test summary captured in the commit
>     message.
>   - Changed Cc: stable@kernel.org -> stable@vger.kernel.org now that the
>     bug is no longer embargoed.
>   - Rebased onto net/main (no functional change to the diff).
>
> v1 was sent to security@kernel.org on 2026-05-10 (not on lore archives;
> no public link available).  v1 review summary, for reference:
>   - Stefano Garzarella (vsock maintainer): "Overall LGTM, but I'd wait
>     vmware guys on this that know this code better."  Asked for retest
>     and resubmission via the net tree workflow.
>   - Bryan Tan (VMCI maintainer): "Thanks for the fix, it looks good to
>     me."  Also noted that no modern VMware product allows guest-to-guest
>     VMCI communication, so the practical attack surface is host -> guest.
>
>  net/vmw_vsock/vmci_transport.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Acked-by: Bryan Tan <bryan-bt.tan@broadcom.com>

>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 4296ca1..88d7128 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1269,14 +1269,16 @@ vmci_transport_recv_connecting_server(struct sock=
 *listener,
>  destroy:
>         pending->sk_err =3D skerr;
>         pending->sk_state =3D TCP_CLOSE;
> -       /* As long as we drop our reference, all necessary cleanup will h=
andle
> -        * when the cleanup function drops its reference and our destruct
> -        * implementation is called.  Note that since the listen handler =
will
> -        * remove pending from the pending list upon our failure, the cle=
anup
> -        * function won't drop the additional reference, which is why we =
do it
> -        * here.
> +       /* Drop the reference taken by vmci_transport_recv_listen() befor=
e
> +        * schedule_delayed_work() only on real errors.  For a peer RST
> +        * (err =3D=3D 0) the listener leaves pending on the pending list=
, and
> +        * vsock_pending_work() will drop that reference itself when it
> +        * later cleans the socket up.  Calling sock_put() here in that
> +        * case would be a double-put and free the socket while
> +        * vsock_pending_work() still holds it.
>          */
> -       sock_put(pending);
> +       if (err < 0)
> +               sock_put(pending);
>
>         return err;
>  }
>
> base-commit: be48e5fe51a5864566307998286a699d6b986934
> --
> 2.54.0
>

--00000000000084453a06519e9ef6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
kKXUf8BmgVwrm4J21BIjpK/E9/meSALtIG7FIMpiIKpgHf1MRTzmYywQIWohaXxPRAEIYZK2DSMY
n+fDChhou4ePAtzo6/x8PTSWPrJbH05U1DQt9FRG7+xcvkNqnjJq+XZK0kiDDFD8BzIKO/cq3ziS
50EhbzFKXPpa46ztpJqQ+UJTJod2dB7SexAYJlBkjKlGc+niNQIDAQABo4IB2jCCAdYwDgYDVR0P
AQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgw
NqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDAk
BgNVHREEHTAbgRlicnlhbi1idC50YW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQWxgja/oUqPdrOSir6
U+YDJVND/DANBgkqhkiG9w0BAQsFAAOCAgEAIL+CGrIYdRkQ80Psq9FtFG65/EZQH8dFSXv3AJTk
220m3Q98q4NHh+AkBRw/pvzVQMJlRKEBKgM1qYw5FYYoC3IRpeqQ9NqnJHsEAHX2p7Hfkt3l8zd7
rT9DuQ4Tws1Fjxo4L7OcRz8NDD9f0Y+LHADvcMUHoex2PldpXkGuWd4K1eMjga8xPOrKKYYdvWYw
cX/rc+AYfo3B0OnjSWXjdsufMPVDDK23uGYfti1djyVhYG7hOCKjW3fg9QdDcVjVa4q7spoCPGnQ
HGghAH5+ZauOJU1r26oGjwR/73xvsig9pX887/zvEM5WdbTXK82mciLRR4iQB0UlV+8UxxpJzfGd
j/6onem1o3e1fTH0owcQEn59i7Ygo5cWJm0qnT7zPTS6pgkXJ4xmskj6Dcqi/hRkMlxovq3K05uN
+lgAFg6F7ugpiGTUcxngHsGMRlj8cXIhg8KZO0gBU5KthBSvioQgN2JpAyE5gUV7stnVCu8l+SAr
Oo+OqcCeAc14zE+TlRnoQVn/xF+q0zAyONDNmQO4uyl0EyLpTIYLK7wFxC6IDrz2FsEzlioH2cBJ
lUyNMZuhR7c1KUj3dr4qBG1506iDiJ5qqn2rBKJAvk0ph2Irlh+82seX1iL/wX+M+Wwkzoo34GGq
6CGv4ffBr8W+eQ2/QT4X10tgfAgSZ+Sag3gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgx+bIvtS2ArBR9RakkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
IEpkaUONAsOygFvcB8jIOtP2zmmgUtq3e6SHK32KqxzaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxMjEzMTI0NlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHzP3T4WPue/akYrPLRFH0TBNfxlTaABeN2K
pUTDK+W1b5atddPW77XtFCtt0K6PAC8qK7qySauCc/hlUDGt/tAJ+vZ57lLzA6Ra9Ekc5GuHldZI
V/UXR+IIJtF4pNWh7ptL4oSt8ZTyi3JJ6jIejaBQQJ9x7OcZfF/5GwhPlguv8C/Krc/o+dnMOXes
maqKJzP075e6mlI1rqHpJg/DOJbS6W2rGHETcrBRDgVBuyuawDRzcD7hvspMLWykUTesgvNjQlwu
4X9KCi15/15SO+FiNa/++7Zb8GUIG1Sq7HuAje4ztQJmxwVu0Ih1rYXfGrLnNR2dB4EYJobZyknI
V0M=
--00000000000084453a06519e9ef6--

